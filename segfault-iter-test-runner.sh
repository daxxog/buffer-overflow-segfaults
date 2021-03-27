#!/bin/bash
# segfault-iter-test-runner.sh

i=0
echo 'buffer size,input size to segfault' > segfaults.csv


while [ $i -lt 64 ]; do
	let i=$i+1

	echo "make BOF.c BOF TRY_BUFFER_SIZE=${i}" | bash
	printf "$i," \
	>> segfaults.csv

	./bf.sh |& \
	grep "Found" | \
	awk '{split($0,a," ");print a[5]}' \
	>> segfaults.csv
done

