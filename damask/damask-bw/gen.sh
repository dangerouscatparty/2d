#!/bin/bash
#
# CC0

fn="damask-bw-1"
svg="$fn.svg"
xfn="$fn-ord.gp"
r="2000000"
b="40000000"

svg2ngc $svg

v=$r
clipcli -R $v -T -s $xfn > $xfn.out.1

v=`expr 2 '*' $r`
clipcli -R $v -T -s $xfn > $xfn.out.2

v=`expr 3 '*' $r`
clipcli -R $v -T -s $xfn > $xfn.out.3

v=`expr 4 '*' $r`
clipcli -R $v -T -s $xfn > $xfn.out.4

v=`expr 5 '*' $r`
clipcli -R $v -T -s $xfn > $xfn.out.4


clipcli -T -B -b $b -s $xfn > $xfn.box

v="$r"
clipcli -R $v -s $xfn.box  > $xfn.in.1

v=`expr 2 '*' $r`
clipcli -R $v -s $xfn.box  > $xfn.in.2

v=`expr 3 '*' $r`
clipcli -R $v -s $xfn.box  > $xfn.in.3

v=`expr 4 '*' $r`
clipcli -R $v -s $xfn.box  > $xfn.in.4

