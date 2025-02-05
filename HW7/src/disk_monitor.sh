#!/bin/bash
THRESHOLD=80  # Поріг використання диска
USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Перевірка, чи змінна USAGE містить числове значення
if [[ -z "$USAGE" || ! "$USAGE" =~ ^[0-9]+$ ]]; then
  echo "[$TIMESTAMP] Error: Failed to retrieve disk usage." >> /var/log/disk.log
  exit 1
fi

# Логування для перевірки
echo "[$TIMESTAMP] Disk usage: $USAGE%" >> /var/log/disk.log

if [ "$USAGE" -ge "$THRESHOLD" ]; then
  echo "[$TIMESTAMP] Warning: Disk usage is at $USAGE%" >> /var/log/disk.log
fi
