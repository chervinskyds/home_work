#!/bin/bash
if [ $# -ne 1 ]; then
  echo "Використання: $0 <ім'я файлу>"
  exit 1
fi

if [ -e "$1" ]; then
  lines=$(wc -l < "$1")
  echo "Кількість рядків у файлі $1: $lines"
else
  echo "Файл $1 не існує."
fi
