#!/bin/bash

CONFIG_FILE="$(dirname "$0")/check-private-repo.txt"
REMOTE_URL=$2

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Push blocked: Configuration file '$CONFIG_FILE' not found."
    exit 1
fi

match_regex() {
    [[ "$1" =~ $2 ]]
}

any_match_found=false

while IFS= read -r line || [[ -n "$line" ]]; do
    regex_A=$(echo "$line" | cut -d ' ' -f 1)
    regex_B=$(echo "$line" | cut -d ' ' -f 2)

    if match_regex "$REMOTE_URL" "$regex_A"; then
        any_match_found=true
        if ! match_regex "$REMOTE_URL" "$regex_B"; then
            echo "Push blocked: $REMOTE_URL matches '$regex_A' but does not match '$regex_B'."
            exit 1
        fi
    fi
done < "$CONFIG_FILE"

if ! $any_match_found; then
    echo "Push blocked: No match found for the remote URL '$REMOTE_URL'."
    exit 1
fi

exit 0
