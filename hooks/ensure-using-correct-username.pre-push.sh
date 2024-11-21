#!/bin/bash

CONFIG_FILE="$(dirname "$0")/check-correct-username.txt"
REMOTE_URL=$2

echo "#   git--dotfiles/hooks/pre-push, local hooks are disabled"
echo -n "CHECKING IF REMOTE URL AND USER.NAME MATCH CONFIGURED PATTERNS"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Push blocked: Configuration file '$CONFIG_FILE' not found."
    exit 1
fi

match_regex() {
    [[ "$1" =~ $2 ]]
}

USER_NAME=$(git config user.name)

any_match_found=false

while IFS= read -r line || [[ -n "$line" ]]; do
    regex_A=$(echo "$line" | cut -d ' ' -f 1)
    regex_B=$(echo "$line" | cut -d ' ' -f 2)

    if match_regex "$REMOTE_URL" "$regex_A"; then
        any_match_found=true
        if ! match_regex "$USER_NAME" "$regex_B"; then
            echo "Push blocked: $REMOTE_URL matches '$regex_A' but user.name '$USER_NAME' does not match '$regex_B'."
            exit 1
        fi
    fi
done < "$CONFIG_FILE"

if ! $any_match_found; then
    echo "Push blocked: No match found for the remote URL '$REMOTE_URL'."
    exit 1
fi

echo "All checks passed. Proceeding with push."
exit 0
