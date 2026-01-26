#!/bin/bash

# PERFORMANCE BENCHMARK
# Block commits if startup time exceeds the threshold.

THRESHOLD_MS=60
MAX_RETRIES=5
LOG_FILE="/tmp/nvim_start.log"

echo "--------------------------------------------------------"

total_time=0

for i in $(seq 1 $MAX_RETRIES); do
  nvim --headless --startuptime "$LOG_FILE" -c 'quit' > /dev/null 2>&1

  # Extract the specific line containing the final timestamp
  # This ignores trailing newlines or empty space at the end of the file.
  last_line=$(grep "NVIM STARTED" "$LOG_FILE" | head -n 1)

  if [ -z "$last_line" ]; then
    echo "⚠️  Error: 'NVIM STARTED' tag not found in log."

    # Fallback: Try the last non-empty line just in case
    last_line=$(grep -v '^$' "$LOG_FILE" | tail -n 1)
  fi

  # Extract the time (First column: "059.014")
  raw_time=$(echo "$last_line" | awk '{print $1}')

  # Extract the integer part (Before the dot: "059")
  int_part=$(echo "$raw_time" | cut -d '.' -f 1)

  # Force Base-10 Arithmetic
  # '10#' tells Bash to treat the number as decimal, ignoring leading zeros.
  # Ensure it defaults to 0 if empty to prevent syntax errors.
  time_ms=$((10#${int_part:-0}))

  # Validation
  if [ "$time_ms" -eq 0 ]; then
     echo "⚠️  Warning: startuptime reported 0ms. Retrying..."
  fi

  total_time=$((total_time + time_ms))
done

average_time=$((total_time / MAX_RETRIES))

if [ "$average_time" -gt "$THRESHOLD_MS" ]; then
  echo "❌ FAILURE: Startup time ${average_time}ms exceeds limit of ${THRESHOLD_MS}ms."
  echo "   Optimize your config before committing."
  echo "--------------------------------------------------------"
  exit 1
else
  echo "✅ SUCCESS: Average startup time: ${average_time}ms"
  echo "--------------------------------------------------------"
  exit 0
fi
