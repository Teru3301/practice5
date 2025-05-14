#!/bin/bash

response=$(curl -s "http://localhost:3030/time")
time_value=$(echo $response | jq -r '.time')

if [ -z "$time_value" ] || [ "$time_value" == "null" ]; then
    echo "Test failed: /time did not return valid JSON"
    exit 1
fi

if [ "$time_value" -eq 0 ]; then
    echo "Test failed: time value is 0"
    exit 1
fi

echo "Test passed: /time returned valid non-zero timestamp"
exit 0
