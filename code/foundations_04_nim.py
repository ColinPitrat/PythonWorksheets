#!/usr/bin/python
# -*- coding: utf8 -*-"

def game(players):
    """
    A generic version of the game. This function takes an array of player types as parameters.
    It can support ["human", "human"], ["computer", "human"], ["human", "computer"] and even ["computer", "computer"]
    A next step could be to move the computer decision into a function and support multiple algorithms:
     - random play
     - perfect play
     - random until heap is small, perfect after
     - perfect play with probability
     - loop over 1, 2 and 3
     - ...
    """
    heap=21
    player=1
    while heap != 0:
        print(f"Heap size: {heap}")
        num = 0
        if players[player-1] == "computer":
            num = heap%4
            if num == 0:
                num = 1
            if num == heap and num > 1:
                num -= 1
            print(f"Player {player} (computer) takes {num} coins")
        else:
            while num == 0:
                num = input(f"Player {player}, how many coins do you take? ")
                try:
                    num = int(num)
                except:
                    num = 0
                if num < 1 or num > 3 or num > heap:
                    num = 0
        player = 1 if player == 2 else 2
        heap -= num
        print()

    print(f"Player {player} wins. Congratulations!")


def pvp():
    """
    The human vs. human version of the game.
    That's the expected "first version" to write in the exercise.
    """
    heap=21
    player=1
    while heap != 0:
        print(f"Heap size: {heap}")
        num = 0
        while num == 0:
            num = input(f"Player {player}, how many coins do you take? ")
            try:
                num = int(num)
            except:
                num = 0
            if num < 1 or num > 3 or num > heap:
                num = 0
        heap -= num
        player = 1 if player == 2 else 2
        print()

    print(f"Player {player} wins. Congratulations!")


def pvc():
    """
    The human vs. computer version of the game.
    Overall it's fine, but you can see it duplicates a lot of logic with the human vs. human.
    """
    heap=21
    player=1
    while heap != 0:
        print(f"Heap size: {heap}")
        num = 0
        if player == 1:
            while num == 0:
                num = input(f"Player {player}, how many coins do you take? ")
                try:
                    num = int(num)
                except:
                    num = 0
                if num < 1 or num > 3 or num > heap:
                    num = 0
        else:
            num = heap%4
            if num == 0:
                num = 1
            if num == heap and num > 1:
                num -= 1
            print(f"Player {player} (computer) takes {num} coins")
        heap -= num
        player = 1 if player == 2 else 2
        print()

    print(f"Player {player} wins. Congratulations!")


print()
print(f"╔═══════════════════════════╗")
print(f"║ The wonderful game of Nim ║")
print(f"╚═══════════════════════════╝")
print()
print(" 1. Human vs. human ")
print(" 2. Human vs. computer ")
print(" 3. Computer vs. human ")
print(" 4. Computer vs. computer ")
print()
choice = 0
while choice not in [1, 2, 3, 4]:
    choice = input(f"Your choice: ")
    try:
        choice = int(choice)
    except:
        choice = 0
if choice == 1:
    #pvp()
    game(["human", "human"])
elif choice == 2:
    #pvc()
    game(["human", "computer"])
elif choice == 3:
    game(["computer", "human"])
else:
    game(["computer", "computer"])
