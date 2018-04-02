#!/bin/bash
#
# CC0

fn="damask-bw-1"
svg="$fn.svg"
xfn="$fn-ord.gp"
#r="1000000"
r="900000"
b="40000000"

#sfactor="0.35"
sfactor="0.25"

sfx_rapid="F3000"
sfx_slow="F800"

mul="1000000"
invmul=` echo "$sfactor / ( $mul ) " | bc -l`

svg2ngc $svg

clipcli -T -B -b $b -s $xfn > $xfn-again.box

v="$r"
clipcli -T -R $v -s $xfn-again.box  > $xfn-again.in.1
#clipcli -R $v -s $xfn-again.box  -x $xmulinv -F > $xfn-again.in.1


gp2ngc -i $xfn-again.in.1 --sfx-rapid "$sfx_rapid" --sfx-slow "$sfx_slow" > oot

gp2ngc -i $xfn-again.in.1 --sfx-rapid "$sfx_rapid" --sfx-slow "$sfx_slow" | \
  ngc_scale -s "$invmul" | \
  ngc_translate -f /dev/stdin -x -45 -U -S | \
  egrep -v '^\(' | \
  sed 's/^G1 /G1 F1000 /' > damask_bw.ngc


