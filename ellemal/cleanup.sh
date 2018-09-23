#!/bin/bash

ifn="$1"


if [[ "$1" == "" ]] ; then
  echo "provide gcode file"
  exit 1
fi

z=`mktemp`

ofn=`basename $ifn .gcode`.ngc

cp "$ifn" "$z"
dos2unix "$z"
cat "$z" | sed  's/;.*//' | sed 's/  *$//' > $ofn

rm -f "$z"
