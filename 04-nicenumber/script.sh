#!/bin/bash

# Given a number, display it in a coma-seperated form.
# Expects decimal point delimiter and thousands delimiter

nicenumber()
{
  #It's assumed that '.' is the decimal seperator
  integer=$(echo $1 | cut -d. -f1)  # Left of the decimal
  decimal=$(echo $1 | cut -d. -f2)  # Right of the decimal

  # Check if number has more than the integer part
  if [ "$decimal" != "$1" ]; then
    # Include the fractional part
    result="${DD:= '.'}$decimal"
  fi

  thousands=$integer

  while [ $thousands -gt 999 ]; do
    remainder=$(($thousands % 1000))  # Remove three least significant digits from the numeric value

    # What an insane trick!
    # If the string length is not in the 100s range
    while [ ${#remainder} -lt 3 ] ; do
      remainder="0$remainder" #Append 0 to the string
    done

    result="${TD:=","}${remainder}${result}"
    thousands=$(($thousands / 1000))    # Continue with the next 4 digits if any
  done

  nicenum="${thousands}${result}"
  if [ ! -z $2 ] ; then
    echo $nicenum
  fi
}

DD="."  # Decimal point delimiter, to seperate whole and fractional values
TD=","  # Thousands delimiter to seperate every three digits

# Main

# This is how we fetch options specified in the cmd
# currently we handle -d and -t which specify delimiters types
while getopts "d:t:" opt; do
  case $opt in
    d ) DD="$OPTARG"     ;;
    t ) TD="$OPTARG"     ;;
  esac
done
shift $(($OPTIND - 1))

# Input validation
if [ $# -eq 0 ] ; then
  echo "Usage: $(basenam $0) [-d c] [-t c] number"
  echo "  -d specifies the decimal poin delimiter"
  echo "  -t specifies the thousands delimiter"
  exit 0
fi

nicenumber $1 1 # The second arg forces nicnumber to 'echo' output

exit 0
