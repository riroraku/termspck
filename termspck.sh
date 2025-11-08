#!/usr/bin/env bash

# check options
if [ "$1" == "" ] || [ "$2" == "" ]; then
	echo -e "No arguments supplied!"
	echo -e "Usage: $0 [docroot] [port]"
	echo -e "\t[docroot]         PHP server docroot, also"
	echo -e "\t                  the dir to store fetched files."
	echo -e "\t                  NOTE: Dont add additional '/'"
	echo -e "\t                    [X] /sdcard/riro/"
	echo -e "\t                    [/] /sdcard/riro"
	echo -e "\t                  See PHP documentation."
	echo -e "\t[port]            PHP server port. Use port"
	echo -e "\t                  between 1024-49151."
	echo -e "\t                  See PHP documentation."
	exit 1
fi

if [ -e "termspck-fetcher.sh" ]; then
	# checks if path exist
	[ ! -d "$1" ] && echo "$1 is not a working directory! Exit." && exit 67
	
	chmod 700 'termspck-fetcher.sh'
	# setup php server
	php -S "localhost:$2" -t "$1" &> "$1/.php.log" &
	phpPID="$!"
	# fetch source file from spck's port every 0.5s
	#(watch -n 0.5 "./termspck-fetcher $3" &> /dev/null) &
	bash -c "while true; do ./termspck-fetcher.sh $1 > /dev/null 2>&1; sleep 0.5; done" &
	watcherPID="$!"
	
	echo "CMD php -S ...  , PID: $phpPID"
	echo "CMD bash -c ... , PID: $watcherPID"
	echo -e "To kill those processes, \`kill -9 <PID>\`, or "
	echo -e "To check those processes, \`kill -0 <PID>\`"
	exit 0
else
	echo -e "MISSING U \e[1;35m//>/v/<//\e[0m"
	echo "Missing termspck-fetcher.sh"
	exit 69
fi



