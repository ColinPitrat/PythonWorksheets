#import "../template.typ": *

#show: doc => cs_sheet(
  title: "4. Programs",
  lang: "en",
  doc,
)

So far we’ve seen how to type python instructions in IDLE Shell and get immediate results. But to write a program, we need to be able to group many of these instructions in a file so that we can run them whenever we want without having to type them every time.

= New file

In IDLE Shell, click on the menu `File` and then on `New File`.
This opens a new window:

#align(center)[
#image("../../resources/screenshots/new_file.png", width: 30%)
]

The new window is a *text editor*. It allows to type some text and *save* it in a *file*. Later, you can *open* this file to modify it.

Let’s type the following instructions, from previous sheet, in the file:

```
for i in range(5, 10):
    print(i)
```

You can then click on the `Run` menu and then on `Run Module`. Note that another way to do this is to press `F5`, as shown in the menu.

A message box is displayed saying that the file is not saved. Before being able to run it, you need to save it a first time to give it a *name*. 

It can be annoying to be asked every time if you want to save. To avoid this, you can go in `Options > Configure IDLE > Shell/Ed > Editor Preferences > At Start or Run (F5)` and check `No Prompt`.

Notice how the result of the execution of your program is visible in IDLE Shell.

= Larger program

Type the following in the file:
```
name = input("Hello, what's your name? ")
print("Nice to meet you %s" % name)
age = int(input("How old are you? "))

if age < 7:
    print("You're a small child!")
elif age < 13:
    print("You're a child!")
elif age < 20:
    print("You're a teen!")

if age >= 18:
    print("You're an adult!")
```

#attention[
Note that we use int when we read the age. This is because we want an integer, not a string.
]

#experiment[
Look at this program before playing with it. Can you guess what it will do? Try giving it various ages. Does it behave as you expected? What if you answer your age as text instead of a number? What if you remove int?
Try modifying the program to make it do new things.
]

= Practice

== Ticket machine

Write a program for a ticket selling machine for a zoo:
 - toddlers tickets ($lt$4 years old) are free
 - child tickets are 5€
 - adult tickets are 10€
 - senior tickets are 7€

The program repeatedly asks the age of the person for which to buy a ticket. Entering "done" tells it that there are no more tickets to buy.
For each ticket, it's giving the price of the ticket and the running total (how much it costs so far considering all the tickets selected).

Run it repeatedly, test it carefully and make it beautiful. It's your first program that you'll save and keep on the long term!

== Sweet dispenser

Write a sweet vending machine program.

You start with a budget (for example 10€). The machine has a choice of sweet at different prices. You can order some until you exhaust your budget or ask for it to stop.

Bonus points: there's a limited number of each type of sweet. Keep track of the count of how much remains and only allow to buy the ones that are still available.

== The game of Nim

Write a program to play Nim. It's a game for 2 players.

There's a pile of 21 coins. At each turn, the player can take between 1 and 3 coins from the pile. The one who takes the last coin loses.

Start by writing the game so that 2 human players can play it. Can you extend it so that the second player is the computer? Can you make it good at playing?
