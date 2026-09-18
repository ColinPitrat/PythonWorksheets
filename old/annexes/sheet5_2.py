import random
import statistics

MIN = 0
MAX = 100

def round():
    number = random.randint(MIN, MAX)

    print("I'm thinking of a number between %s and %s, can you guess it?" % (MIN, MAX))

    guesses = 0
    while True:
        try:
            guess = int(input("What's your guess? "))
        except:
            continue
        guesses += 1
        if guess < number:
            print("My number is bigger than %s" % guess)
        elif guess > number:
            print("My number is smaller than %s" % guess)
        else:
            print("Well done! My number is indeed %s. Found in %s guesses" % (number, guesses))
            break
    return guesses

def show_stats(numbers):
    print("Your stats over %s rounds:" % len(numbers))
    print("  Min:     ", min(numbers))
    print("  Mean:    ", statistics.mean(numbers))
    print("  Median:  ", statistics.median(numbers))
    print("  Std dev: ", statistics.pstdev(numbers))
    print("  Max:     ", max(numbers))

print("")
print(" ===== GUESSING GAME =====")
print("Welcome to the guessing game!")
print("")

replay = "y"
all_guesses = []
while replay != "n" and replay != "no":
    all_guesses.append(round())
    print("")
    replay = ""
    while replay not in ["n", "no", "y", "yes"]:
        replay = input("Do you want to play again? (y/n)")

print("")
show_stats(all_guesses)
print("")
print("Good bye!")
print("")
    
