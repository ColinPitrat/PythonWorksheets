#!/usr/bin/python
# -*- coding: utf8 -*-"
import math
import random
import time

def game(min_n, max_n, max_tries):
    number = random.randint(min_n, max_n)

    print("I'm thinking of a number between %s and %s, can you guess it?" % (min_n, max_n))

    begin = time.time()
    tries = 0
    while True:
        if tries >= max_tries:
            print()
            print("Too bad, you lost!")
            print(f"You failed to find my number {number} after {tries} tries.")
            break
        guess = None
        while guess is None:
            guess = input("What's your guess? ")
            if guess in ["menu", "quit"]:
                return guess
            try:
                guess = int(guess)
            except:
                guess = None
        if guess < number:
            print("My number is bigger than %s" % guess)
        elif guess > number:
            print("My number is smaller than %s" % guess)
        else:
            end = time.time()
            print()
            print("Well done! My number is indeed %s" % number)
            print(f"You found the correct answer in {int(end-begin)}s and {tries} tries.")
            break
        tries += 1

    print("GAME OVER!")
    return ""


print()
print(f"╔═══════════════╗")
print(f"║ Guessing game ║")
print(f"╚═══════════════╝")
while True:
    print()
    print("Choose your difficulty level:")
    print(" 1. Easy")
    print(" 2. Medium")
    print(" 3. Hardcore")
    print("Or type `quit` to quit.")
    print()

    choice = 0
    while choice not in [1, 2, 3]:
        choice = input(f"Your choice: ")
        if choice == "quit":
            break
        try:
            choice = int(choice)
        except:
            choice = 0
    if choice == "quit":
        break

    while True:
        print()
        print("Type `menu` instead of a number to go back to difficulty choice.")
        print("Type `quit` instead of a number to quit.")
        print()
        if choice == 1:
            min_n = 0
            max_n = 100
            max_tries = 20
        elif choice == 2:
            min_n = 0
            max_n = 1000
            max_tries = 12
        else:
            min_n = random.randint(0, 500)
            max_n = random.randint(min_n+200, 1000)
            max_tries = int(math.log2(max_n-min_n)+1)

        keyword = game(min_n, max_n, max_tries)
        if keyword in ["menu", "quit"]:
            break

    if keyword == "quit":
        break

print("Good bye!")
