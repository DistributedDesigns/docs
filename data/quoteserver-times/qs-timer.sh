#!/bin/sh

if [ -z $1 ]; then
	echo "Usage: $0 [num attempts] 2> <file>"
	exit 1
else
	MAX_ITER=$1
fi

TIMEFORMAT=%R
for i in `seq 1 ${MAX_ITER}`; do
	time echo "hello,friend" | nc quoteserve.seng.uvic.ca 4443 > /dev/null
done
