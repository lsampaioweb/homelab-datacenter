#!/bin/bash

# Measure execution time of a function.
# Usage: measure_time "operation name" function_name [args...].
measure_time() {
  local operation="$1"
  local func="$2"
  shift 2
  TIMEFORMAT="$operation took %R seconds."
  time "$func" "$@"
  echo ""
}
