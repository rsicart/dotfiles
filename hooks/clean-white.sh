#!/bin/bash

echo "Check for trailing whitespaces and tabs...";

# Check PHP debug traces
phpPattern="[[:space:]]$"
for file in $(git diff --staged --stat | grep '\.php' | awk '{print $1}'); do
	grep -e "$phpPattern" $file 2>/dev/null 1>&2 
	if [ $? -eq 0 ]; then
		echo -e "\e[31mError: trailing whitespaces found on file: $file"
		exit 1
	fi
done;

exit 0
