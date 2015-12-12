#/bin/bash
wlaninterface=mon0
#airmon-ng start $wlaninterface
outputprefix=output
sleeptime=30s
maxclients=150
while true; do
rm $outputfileprefix*.csv &> /dev/null
airodump-ng -w $outputprefix --output-format csv $wlaninterface  &> /dev/null &
sleep $sleeptime
kill $!
grep -aA $maxclients 'MAC' `ls $outputprefix*.csv` | grep "$1" | awk '{print $1$6$8}' | sed -e '/Station/d' > list_of_station
# | grep "$1"                                  \
# | sed -e '/Station/d' -e 's/,//'        \
# | awk '{print $1}' > list_of_station
cat list_of_station
done