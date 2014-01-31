#!/bin/bash

echo "Searching for debug traces...";

# Check PHP debug traces
phpPattern="var_dump"
for file in $(git diff --staged --stat | grep '\.php' | awk '{print $1}'); do
	grep "$phpPattern" $file 2>/dev/null 1>&2 
	if [ $? -eq 0 ]; then
		echo -e "\e[31mError: debugging traces on file: $file"
		exit 1
	fi
done;

exit 0
