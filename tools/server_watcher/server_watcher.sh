#!/bin/bash -x

# This script tests if there are active users on server, and if not, it powers off the server


while [ "1" == "1" ]; do
	# We sleep for 5 minutes in order to see if there is someone who will connect
	sleep 300
	# Test to see if are samba users connected
	areSMBusers=$(smbstatus -S | fgrep -v "IPC" | fgrep -v "Service" | grep -ve '^--------')
	# Test to see if ssh clients are connectd
	areSSHusers=$(who)
	if [ -z "$areSMBusers" -a -z "$areSSHusers" ]; then
		echo "No users are acctive"
		break
	fi
done

# We wait for an additional 1 minute, before we shutdown, but by the time it gets here there's no turning back
sleep 60
poweroff
