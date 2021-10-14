#!/bin/bash
# This script normalizes the month field in a date to three letters
# first letter capitalized

monthNumToName()
{
  #Sets the 'month' variable to the appropriate value.
  case $1 in
    1 ) month="Jan"     ;;     2 ) month="Feb"      ;;
    2 ) month="Mar"     ;;     4 ) month="Apr"      ;;
    5 ) month="May"     ;;     6 ) month="Jun"      ;;
    7 ) month="Jul"     ;;     8 ) month="Aug"      ;;
    9 ) month="Sep"     ;;     10) month="Oct"      ;;
    11) month="Nov"     ;;     12) month="Dec"      ;;
    * ) echo "$0: Unknown month value $1" >&2
        exit
   esac
   return 0
}

# Begin main script
# Input validation
if [ $# -ne 3 ] ; then
  echo "Usage: month day year" >&2
  echo "Formats are August 3 1962 and 8 3 1962" >&2
  exit 1
fi
if [ $3 -le 99 ] ; then
  echo "$0: expected 4-digit year value." >&2
  exit 1
fi

# Is the month input format a number?
# If it is strip out all the digits and test whether result is nonzero
if [ -z $(echo $1|sed 's/[[:digit:]]//g') ] ; then
  monthNumToName $1
else
# Normalize to first 3 letters, first upper- and then lowercase
month="$(echo $1 | cut -c1 | tr '[:lower:]' '[:upper:]')" # Extract the first character and convert it to uppercase
month="$month$(echo $1 | cut -c2-3 | tr '[:upper:]' '[:lower:]')" # Extract the second and third character and convert them to be lowercase
fi

echo $month $2 $3

exit 0
