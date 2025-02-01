#!/bin/bash
read -p "Введіть ім'я файлу: " filename
if [ -e "$filename" ]; then
  echo "Файл $filename існує."
else
  echo "Файл $filename не існує."
fi
