#!/bin/bash
read -p "Введіть ім'я файлу: " filename
if [ -e "$filename" ]; then
  cat "$filename"
else
  echo "Помилка: файл $filename не знайдено."
fi
