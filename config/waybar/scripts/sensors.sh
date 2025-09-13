#!/bin/bash

# ---------------------
# CPU
# ---------------------
cpu_temp_raw=$(sensors | grep 'Tctl:' | awk '{print $2}' | sed 's/+//' | sed 's/°C//')
cpu_temp=${cpu_temp_raw%.*}

if [ "$cpu_temp" -lt 45 ]; then
  icon_cpu="" # cold
elif [ "$cpu_temp" -lt 65 ]; then
  icon_cpu="" # normal
else
  icon_cpu="" # hot
fi

# ---------------------
# GPU
# ---------------------
gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null)

if [ -n "$gpu_temp" ]; then
  if [ "$gpu_temp" -lt 45 ]; then
    icon_gpu=""
  elif [ "$gpu_temp" -lt 70 ]; then
    icon_gpu=""
  else
    icon_gpu=""
  fi
  echo "CPU: $icon_cpu ${cpu_temp}°  GPU: $icon_gpu ${gpu_temp}°"
else
  echo "CPU: $icon_cpu ${cpu_temp}°"
fi
