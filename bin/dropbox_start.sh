#!/bin/bash

/usr/bin/dropbox stop 
/usr/bin/dbus-launch /usr/bin/dropbox start -i &
