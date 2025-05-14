#!/bin/bash

# Проверяем, что сервер запущен (попробуем получить /time сначала)
time_response=$(curl -s "http://localhost:3030/time")
if [ $? -ne 0 ]; then
    echo "Error: Could not connect to server. Is it running on port 3030?"
    exit 1
fi

# Делаем несколько запросов к /time чтобы увеличить счетчик
for i in {1..3}; do
    curl -s "http://localhost:3030/time" > /dev/null
done

# Получаем метрики
response=$(curl -s "http://localhost:3030/metrics")
count_value=$(echo $response | jq -r '.count')

# Проверки
if [ -z "$count_value" ] || [ "$count_value" == "null" ]; then
    echo "Test failed: /metrics did not return valid JSON"
    exit 1
fi

if ! [[ "$count_value" =~ ^[0-9]+$ ]]; then
    echo "Test failed: count value is not a number"
    exit 1
fi

if [ "$count_value" -lt 3 ]; then
    echo "Test failed: expected count >=3 but got $count_value"
    exit 1
fi

echo "Test passed: /metrics returned valid count ($count_value)"
exit 0

