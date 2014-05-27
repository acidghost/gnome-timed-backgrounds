#!/bin/bash

sleep=600

files=(
    01-Morning.png
    02-Late-Morning.png
    03-Afternoon.png
    04-Late-Afternoon.png
    05-Evening.png
    06-Late-Evening.png
    07-Night.png
    08-Late-Night.png
)

#Timings for the backgrounds in order. Your life may vary.
timing=(
    7
    10
    12
    15
    17
    19
    20
    23
)

while true
do
	hour=`date +%H`
	hour=`echo $hour|sed 's/^0*//'`

	# cron  needs the DBUS_SESSION_BUS_ADDRESS environment variable set
	if [ -z "$DBUS_SESSION_BUS_ADDRESS" ] ; then
		TMP=~/.dbus/session-bus
		export $(grep -h DBUS_SESSION_BUS_ADDRESS= $TMP/$(ls -1t $TMP | head -n 1))
	fi
	#PID=$(pgrep gnome-session)
	#export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

	  
	isSet=0

	for i in {7..0..-1}
	do 
		#echo "LOG: ${timing[i]}"
		if [[ $hour -ge ${timing[i]} ]]; then
			PIC=${files[i]}
			# Set a Background Image
			gsettings set org.gnome.desktop.background picture-uri "file://`pwd`/pics/$PIC"
			echo "Wallpaper set to $PIC"
			isSet=1
			break
		fi
	done

	if [[ isSet -eq 1 ]]; then
		sleep $sleep
		continue
	fi

	PIC=${files[7]}
	# Set a Background Image
	gsettings set org.gnome.desktop.background picture-uri "file://`pwd`/pics/$PIC"
	echo "Wallpaper set to $PIC"
	sleep $sleep
	continue
done
