import random

def guess_number():
    number = random.randint(1, 100)
    attempts = 5

    print("Я загадав число від 1 до 100. Спробуйте його вгадати! У вас є 5 спроб.")

    for attempt in range(attempts):
        try:
            guess = int(input(f"Спроба {attempt + 1}: Введіть число: "))

            if guess == number:
                print("Вітаємо! Ви вгадали правильне число.")
                return
            elif guess > number:
                print("Занадто високо.")
            else:
                print("Занадто низько.")
        
        except ValueError:
            print("Будь ласка, введіть ціле число.")

    print(f"Вибачте, у вас закінчилися спроби. Правильний номер був {number}.")

# Запуск гри
guess_number()
