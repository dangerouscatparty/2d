#!/bin/bash
#

export VERBOSE=1
export spower="1.0"
export fspeed="800"

ifn="$1"

if [[ "$ifn" == "" ]] ; then
  echo "provide input gcode file"
  exit -1
fi

scalef="100000"
iscalef=` echo "1/$scalef" | bc -l`

if [[ "$VERBOSE" -eq 1 ]] ; then
  echo "# $scalef $iscalef"
fi

z=`mktemp`

bname=`basename $ifn .gcode`
ofn="$bname".ngc

cp "$ifn" "$z"
dos2unix "$z"
cat "$z" | sed  's/;.*//' | sed 's/  *$//' > $ofn


if [[ "$VERBOSE" -eq 1 ]] ; then
  echo "$ >> $ofn"
fi

sed 's/  */ /g' $ofn | \
  sed 's/^ *$//' | \
  grep -P '^[gG][01]|^$' | \
  egrep -v '^[gG]0' | \
  sed 's/^[gG][^ ]* *//' | \
  sed 's/S.*//' | \
  tr -d 'xXyY' > $z

echo "DEBUG >>>> $z ... oot"

clipcli -F -s $z -T -x $scalef | \
  gp2ngc --pfx "G21\nG90" | \
  grecode -scale $iscalef | \
  sed 's/^\(G1.*\)/\1 S'$spower' F'$fspeed'/' > ${bname}-x.ngc


#rm -f "$z"
