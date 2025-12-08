import random

min_value = 1
max_value = 100
random_num = random.randint(min_value, max_value)

print(f"I generated a number between {min_value} and {max_value}.")
attempts = 5
print(f"You have {attempts} attempts to guess.")

for i in range(1, attempts + 1):
    try:
        number = int(input(f"Attempt {i}. Enter your number: "))
    except ValueError:
        print("Please enter a valid integer.")
        continue

    if number == random_num:
        print("Congratulations! You guessed the right number.")
        break
    elif number > random_num:
        print("Too high")
    else:
        print("Too low")

    if i == attempts:
        print(f"Sorry, you lose :( You used all attempts. The number was {random_num}.")
