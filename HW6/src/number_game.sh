#!/bin/bash

number_to_guess=$(( RANDOM % 100 + 1 ))
attempts=5

echo "Вгадайте число від 1 до 100. У вас є 5 спроб."

for (( attempt=1; attempt<=attempts; attempt++ )); do
    read -p "Спроба $attempt: Введіть число: " guess

    if ! [[ "$guess" =~ ^[0-9]+$ ]]; then
        echo "Будь ласка, введіть коректне число."
        continue
    fi

    if (( guess == number_to_guess )); then
        echo "Вітаємо! Ви вгадали правильне число."
        exit 0
    elif (( guess < number_to_guess )); then
        echo "Занадто низько."
    else
        echo "Занадто високо."
    fi
done

echo "Вибачте, у вас закінчилися спроби. Правильним числом було $number_to_guess."
