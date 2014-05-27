PIC=`./random-file.py`
echo `date` $PIC

# cron  needs the DBUS_SESSION_BUS_ADDRESS environment variable set
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ] ; then
   TMP=~/.dbus/session-bus
    export $(grep -h DBUS_SESSION_BUS_ADDRESS= $TMP/$(ls -1t $TMP | head -n 1))
  fi

  # Set a Background Image
  gsettings set org.gnome.desktop.background picture-uri "file://`pwd`/pics/$PIC"

