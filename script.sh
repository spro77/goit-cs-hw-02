#!/bin/bash

LOG_FILE="website_status.log"

websites=(
    "https://google.com"
    "https://facebook.com"
    "https://twitter.com"
)

> "$LOG_FILE"

echo "Starting website availability check..."
echo "Results will be logged to: $LOG_FILE"
echo

for website in "${websites[@]}"; do
    echo "Checking $website..."

    http_code=$(curl -L -s -o /dev/null -w "%{http_code}" --max-time 10 "$website")

    if [ "$http_code" -eq 200 ]; then
        status="UP"
        echo "$website is $status"
    else
        status="DOWN"
        echo "$website is $status (HTTP code: $http_code)"
    fi

    echo "$website is $status" >> "$LOG_FILE"
done

echo
echo "Results have been saved to: $LOG_FILE"
echo
echo "Log file contents:"
cat "$LOG_FILE"
