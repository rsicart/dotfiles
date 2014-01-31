#!/bin/bash

echo "Checking syntax...";

# Check PHP syntax
for file in $(git diff --staged --stat | grep '\.php' | awk '{print $1}'); do
	php -l $file 2>/dev/null 1>&2 
	if [ $? -gt 0 ]; then
		echo -e "\e[31mError: PHP syntax errors on file: $file"
		exit 1
	fi
done;
