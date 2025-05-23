#!/bin/bash

CONFIG_FILE="$(dirname "$0")/check-private-repo.txt"
REMOTE_URL=$2

if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "\033[31mConfiguration file '$(basename $CONFIG_FILE)' not found.\033[0m"
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
            echo -e "remote url '$REMOTE_URL' matches \033[32m'$regex_A'\033[0m"
            echo -e "but does not match \033[32m'$regex_B'\033[0m"
            exit 1
        fi
    fi
done < "$CONFIG_FILE"

if ! $any_match_found; then
    echo -e "\033[31mCan not push to $REMOTE_URL, add it to config file\033[0m"
    exit 1
fi

exit 0
