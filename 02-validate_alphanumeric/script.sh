#!/bin/bash

# This script ensures that input consists only of alphabetical
# and numeric characters

validAlphaNum()
{
  #Returns 0 if all upper+lower+digits; 1 otherwise

  validchar="$(echo $1 | sed -e 's/[^[:alnum:]]//g')"

  if [ "$validchar" = "$1" ] ; then
    return 0
  else
    return 1
  fi
}

# Begin main script
/bin/echo -n "Enter input: "
read input

# Input validation
if ! validAlphaNum "$input" ; then
  echo "Please enter only letters and numbers." >&2 #If I remember correctly the statement '>&2'. Redirects output to fd 2
  exit 1
else
  echo "Input is valid."
fi

exit 0
