#!/bin/bash

echo -n "You can usually append the next echo statement "
echo -n "onto the same line as the previous line using the -n option. "
echo "The -n option tells echo to not output the trailing newline (man echo)."

echo

echo "Another way to append echo statements onto the same line is with awk."
echo "\"$*\" | awk '{ printf \"%s\", \$0 }':"
echo "$*" | awk '{ printf "%s", $0 }'

echo "%"
echo
echo "To avoid the overhead incurred when calling the awk command."
echo "If you have a user-level printf command, you can use the following."
echo
echo "printf \"$s\" \"$*\""
printf "%s" "$*"
echo "%"

echo
echo
echo "If you don't have printf and don't want to call awk"
echo "Then use the tr command to chop off any final carriage return:"
echo "echo \"$*\" | tr -d '\n'"
echo "$*" | tr -d '\n'
