#!/bin/bash
# segfault-iter-test-runner.sh

i=0
echo 'buffer size,input size to segfault' > segfaults.csv


while [ $i -lt 64 ]; do
	let i=$i+1

	printf "$i," \
	>> segfaults.csv

	echo "make BOF.c BOF TRY_BUFFER_SIZE=${i}" | bash

	./bf.sh |& \
	grep "Found" | \
	awk '{split($0,a," ");print a[5]}' \
	>> segfaults.csv
done

