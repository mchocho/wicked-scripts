#!/bin/bash

# Wrapper for 'bc' that returns the result of a calculation

if [ "$1" = "-p" ]; then
  precision=$2
  shift 2
else
  precision=2  #Default
fi

'''
The << notation (the here document) at allows you to
include content from the script and treat it as if
it were typed directly into the input stream.
In this case provides an easy mechanism for handing
commands to the bc program.

In this notation, whatever you put after the << sequence
is what it’ll then seek to match (on a line by itself) to
denote the end of that input stream.
'''

bc -q -l << EOF
  scale=$precision
  $*
  quit
EOF

exit 0
