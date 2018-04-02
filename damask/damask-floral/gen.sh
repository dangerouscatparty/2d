#!/bin/bash

fn="damask-floral"
svg="$fn.svg"

outbase="damask-floral"
xfn="$outbase.gp"
#r="1800000"
r="100000"
 rin="1000000"
rout="10000000"
b="40000000"

#sfactor="0.35"
sfactor="0.25"

sfx_rapid=" F3000"
sfx_slow=" F2000"

mul="1000000"
invmul=` echo "$sfactor / ( $mul ) " | bc -l`

svg2ngc $svg


clipcli -T -B -b $b -s $outbase-ord.gp > $outbase.box

clipcli -T -R $rout -s $outbase-ord.gp > $outbase.out.1

v="$r"
clipcli -T -R $rin -s $outbase.box  > $outbase.in.1
#clipcli -R $v -s $xfn-again.box  -x $xmulinv -F > $xfn-again.in.1


gp2ngc -i $outbase.in.1 --sfx-rapid "$sfx_rapid" --sfx-slow "$sfx_slow" > oot

dx=0
dy="-85"
gp2ngc -i $outbase.in.1 --sfx-rapid "$sfx_rapid" --sfx-slow "$sfx_slow" | \
  ngc_scale -s "$invmul" | \
  ngc_translate -f /dev/stdin -x $dx -y $dy -U -S | \
  head -n -8 | \
  egrep -v '^\(' > damask_floral.ngc

gp2ngc -i $outbase.out.1 --sfx-rapid "$sfx_rapid" --sfx-slow "$sfx_slow" | \
  ngc_scale -s "$invmul" | \
  ngc_translate -f /dev/stdin -x $dx -y $dy -U -S | \
  egrep -v '^\(' >> damask_floral.ngc

