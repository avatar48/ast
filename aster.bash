#!/bin/bash
number=$1
name=$3
pass=$4
context=0;
dir='/etc/asterisk/sip.conf'

findandreplace() {
local status
local change
status=`cat /etc/asterisk/sip.conf |sed -n '/username='$number'/{=}'`
echo  "$status"
change=`/bin/sed "$status s/username=$number/username=246/g" $dir`
#echo "$change"
echo "$change" > $dir

}




case $2 in
 localn ) context="local";;
 vneshn ) context="ELEKTROPROFIL_INTERNATIONAL_M";;
esac
status=`grep username=$number /etc/asterisk/sip.conf`
if [ -n "$status" ]
then echo "Takoi nomer uje est"
findandreplace
#while read  line
#do
# echo "$line"
#done < $dir

exit 0;
else
cat <<EOF  >> /etc/asterisk/sip.conf

[$number](phone)
username=$number
secret=$pass
type=friend
host=dynamic
context=$context
callerid=$name <$number>
EOF
/etc/init.d/asterisk restart
fi