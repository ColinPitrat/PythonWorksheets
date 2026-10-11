#import "../template.typ": *

#show: doc => cs_sheet(
  title: "5. Our first game",
  lang: "en",
  doc,
)

Now that we know how to create a program, we can make our first game!

= Our game

Create a new file (`File > New File`)

Let’s type the following in the file:

```
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
```

#attention[
Here are a few things to note in this code:
- Note the first line: `import random`. The keyword `import` tells to python that we want to use a library. The library `random` is part of python’s standard library and provides functions to generate and use random numbers.
- We define some variables `MIN` and `MAX`. That’s because these numbers are used in two places in the program, and although they are fixed for now, we may want to be able to easily change them in the future.
- Note the infinite loop (`while True`). This loop will run forever. But note also the `break` when the player finds the right number. This instruction allows to exit the loop it's in.
]

#experiment[
This game can be really fun. Play with it a lot. What strategy allows you to win with the smallest number of guesses?
You think it’s just a game? It actually hides something very useful in computer science called *bisection*.
]

As you play, do you find ideas on how to make this game better? That’s the great thing about programming: you can always come up with new ideas to make your program better.

= Practice

You can play a bit with the game, but it lacks some things.

== Count guesses and limit them

Modify the game so that it counts your guesses. For now, you can't lose at this game. It's not fun if you can just try 100 possibilities!

Put a limit on the muner of guesses the player has. If the player doesn't find after this many tries, they lose.

== Restart a new game after winning/losing

At the moment, if you want to replay, you have to restart the game (with `F5` or `Run`) everytime you win or lose.

Instead, make the game restart a new game as soon as you win or lose. If the player wants to quit, allow them to enter the command `quit` (and modify the game to tell them).

== Time pressure

Make the game measure the time it takes to find the number.

#pro_tip[
You can `import time` and then call `time.time()` a first time when the game being, and a second time when it ends. The difference between the 2 values is the number of seconds it took. It will be a decimal number. You can use `int(end-start)` to make it a whole number, or `round(end-start, 2)` to only keep 2 decimals.
]

== Multiple levels

Introduce multiple levels in the game, with different difficulties.

For example:
 - level 1 = 0-100 with 20 tries
 - level 2 = 0-1000 with 12 tries
 - level 3 = min and max are chosen randomly, maximum number of tries is `int(math.log2(max-min)+1)`

