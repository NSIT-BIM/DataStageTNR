#!/bin/bash
. $(cat /.dshome)/dsenv
/opt/IBM/InformationServer/Server/DSEngine/bin/dsjob -run -mode RESET -wait dstage1 Js_NR
echo "running test 1 on $1"
echo "run Js_NR"
/opt/IBM/InformationServer/Server/DSEngine/bin/dsjob -run -mode NORMAL -wait  -param table=JOBRUN -param level=5 -param Ps_NR_Db=test "$1" Js_NR
echo "$?"

