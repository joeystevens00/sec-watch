#!/bin/bash
inotifywait -r -m -e modify found_tickers.txt |
while read path _ file
do
       notify-send "$(tail -n1 $path$file)"
done
