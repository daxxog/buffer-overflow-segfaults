#!/bin/bash
i=0
input=''
while [ $i -lt 128 ]; do
       let i=$i+1
       input="$input""A"
       echo "Sending $i characters...";
       ./BOF $input

       	# check for exit code 139 (segfault)
	retVal=$?
	if [ $retVal -eq 139 ]; then
	    echo "Found segfault at sequence: $i"
	    exit $retVal
	fi
done
