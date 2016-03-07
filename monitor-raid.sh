#!/bin/bash
# Sends email if hpacucli output has errors or rebuilds
MAIL=<insert_your_mail>
if [ `/usr/sbin/hpacucli controller slot=2 physicaldrive all show | grep -iE '(Rebuilding|Failed|Error)' | wc -l` -gt 0 ]
then
msg="RAID controller reports errors"
#echo $msg
#$msg2=`/usr/sbin/hpacucli controller slot=2 physicaldrive all show`
/usr/sbin/hpacucli controller slot=2 physicaldrive all show > $HPACUCLI_TMP
#echo $HPACUCLI_TMP
mail -s "$HOSTNAME [ERROR] - $msg" "$MAIL" < $HPACUCLI_TMP
rm -f $HPACUCLI_TMP
fi
