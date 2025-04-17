#!/bin/sh

DENIED_WORDS=(
    "DO NOT COMMIT"
    "libq"
    "lbiq"
    "console.debug"
    "console.log"
    "console.trace"
    "console.time"
    "console.timeEnd"
)

STAGED_FILES=$(git diff --name-only --staged)

should_block_commit=0
for file in $STAGED_FILES; do
  for word in "${DENIED_WORDS[@]}"; do
    DIFF_OUTPUT=$(git diff --staged --patch -- "$file" | grep -i -C 3 -- "$word")

    if echo "$DIFF_OUTPUT" | grep -q "^+.*$word"; then
      git diff --staged --patch | grep -C 4 "^+.*$word" --color
      echo -e "\033[31mAborted: diff adds '$word'\033[0m"
      echo -e "\033[31mFile: '$file'\033[0m"
      should_block_commit=1
      break
    fi
  done
done

if (( should_block_commit == 1 )); then
  exit 1
else
  exit 0
fi
