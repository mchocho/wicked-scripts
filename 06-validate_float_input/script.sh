#!/bin/bash

# validFloat -- Tests whether a number is a valid floating point value
# scientific notation isn't accepted

# We split the value into two parts: the integer portion and the fractional
# portion.

. ./validint.sh

validfloat()
{
  fvalue="$1"

  # Check whether the input number has a decimal point
  if [ ! -z $(echo $fvalue | sed 's/[^.]//g') ] ; then

    # Extract the part before the decimal point
    decimalPart="$(echo $fvalue | cut -d. -f1)"

    # Extract the digits after the decimal point.
    fractionalPart="${fvalue#*\.}"

    # Test the decimal part
    if [ ! -z $decimalPart ] ; then
      # If not a valid integer
      if ! validint "$decimalPart" "" ""; then
        return 1
      fi
    fi

    # Test the fractional value
    # Check if there's no negative sign in the wrong position
    if [ "${fractionalPart%${fractionalPart#?}}" = "-" ] ; then
      echo "Invalid floating-point number: '-' not allowed after decimal point." >&2
      return 1
    fi
    if [ "$fractionalPart" != "" ] ; then
      # If the fractional part is not a valid integer
      if ! validint "$fractionalPart" "0" "" ; then
        return 1
      fi
    fi

  else
    #If the entire value is just "-" then fail
    if [ "$fvalue" = "-" ] ; then
      echo "Invalid floating-point format." >&2
      return 1
    fi

    # Check that the remaining digits are valid integers
    if ! validint "$fvalue" "" "" ; then
      return 1
    fi
  fi

  return 0
}

if validfloat $1 ; then
  echo "$1 is a valid floating-point value."
fi

exit 0
