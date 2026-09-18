import random

MIN = 0
MAX = 100

number = random.randint(MIN, MAX)

print("I'm thinking of a number between %s and %s, can you guess it?" % (MIN, MAX))

while True:
    guess = int(input("What's your guess? "))
    if guess < number:
        print("My number is bigger than %s" % guess)
    elif guess > number:
        print("My number is smaller than %s" % guess)
    else:
        print("Well done! My number is indeed %s" % number)
        break

print("GAME OVER!")
    
