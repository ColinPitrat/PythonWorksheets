#import "../template.typ": *

#show: doc => cs_sheet(
  title: "3. Loops",
  lang: "en",
  doc,
)

Loops are the last important concept we need before we can do some serious programming. We’ll see 2 kinds of loops: `for` loops and `while` loops.

= for loops

A `for` loop allows to do something for each object in a series of objects (called a sequence).

Try this:

```
for name in [“Richard”, “Elizabeth”, “Guido”]:
    print(“Hello”, name)
```

You can see that, as for functions, IDLE shows `...` instead of `>>>` and automatically adds indentation when it’s waiting for your `for` loop body.

The square brackets allowed us to define a list which contains 3 strings (the names). You can try replacing it with an empty list. You can define an empty list with `[]` (which just means removing all the names).

There’s a special function called range which allows to generate a sequence of numbers (integers).
Try the following:

```
for i in range(5):
    print(i)
```

#attention[
Note how it started at 0 and it didn’t include 5. Computer scientists love starting at 0 and stopping before reaching the upper boundary!
]

#experiment[
You can also call range with more parameters. Can you understand what they do?

```
for i in range(5, 10):
    print(i)

for i in range(2, 20, 3):
    print(i)
```
]

= while loops

A `while` loop allows to repeat some action until some condition is met. Try this:

```
answer = “”
while answer != “yes”:
    answer = input(“Do you want to quit this loop? “)
```

#attention[
Note how we have to create (define) the variable answer before the loop. That’s because if we don’t, it doesn’t exist the first time the condition is evaluated to decide whether we enter the loop.
]

#experiment[
Can you quit the loop without answering yes? Can you answer yes without quitting the loop?
]

Here is a way to write the same loop without having to define answer before. Do you understand how it works?

```
while True:
    answer = input(“Do you want to quit this loop? “)
    if answer == “yes”:
        break
```

= Practice

== Factorials

In the first sheet, we computed factorials "by hand", writing things like `10*9*8*7*6*5*4*3*2*1`. It's a bit cumbersome.

Can you write a function that takes an integer and compute it's factorial using a loop?

```
>>> factorial(10)
    3628800
```

== Count down

We need to prepare for the rocket launch 🚀.

Write a function that counts down from a given number down to 1. Then when it reaches 0, it prints "BLAST OFF!" instead of 0.

```
>>> count_down(5)
    5
    4
    3
    2
    1
    BLAST OFF!
```

== Firework simulator

Write a function that will simulate a firework with a given number of rockets. It will alternate between red and blue (or more colors if you want), the last one being the grand finale.

```
firework_show(4)
🎆  1 : it's a red!
🎆  2 : it's a blue!
🎆  3 : it's a red!
🎆🎆🎆 GRAND FINALE!!! 🎆🎆🎆
```
