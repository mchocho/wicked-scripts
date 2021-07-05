#!/bin/bash
# validint -- Validates integer input, allowing negative values too

validint()
{
  # Validate first field and test that value against min and/or max value
  # If the value isn't within range or it's not a digit, fail

  number="$1";     min="$2";     max="$3"

  if [ -z $number ] ; then
    echo "Please enter a number." >&2
    return 1
  fi

  # Check if first character is a '-' sign
  if [ "${number%${numner#?}}" = "-" ] ; then
    testvalue="${number#?}"  # Grab all but the first character to test
  else
    testvalue="$number"
  fi

  # Create a copy of the testvalue but strip all the digits
  nodigits="$(echo $testvalue | sed 's/[[:digit:]]//g')"

  # Check for nondigit characters.
  if [ ! -z $nodigits ] ; then
    echo "Invalid format! Only digitss, no commas, spaces, etc." >&2
    return 1
  fi

  if [ ! -z $min ] ; then
    # Check if input is less than minimum value
    if [ "$number" -lt "$min" ] ; then # -lt is short for less than
      echo "The value $1 is too small. Smallest acceptable value is $min." >&2
      return 1
    fi
  fi
  if [ ! -z $max ] ; then
    if [ "$number" -gt "$max" ] ; then # -gt is short for greater than
      echo "The value $1 is too big. Largest acceptable value is $max." >&2
      return 1
    fi
  fi
  return 0
}

# Main
if validint "$1" "$2" "$3" ; then
  echo "Input is a valid integer within your constraints."
fi
