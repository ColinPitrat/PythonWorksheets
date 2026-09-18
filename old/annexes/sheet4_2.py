name = input("Hello, what's your name? ")
print("Nice to meet you {name}")
age = int(input("How old are you? "))

if age < 7:
    print("You're a small child!")
elif age < 13:
    print("You're a child!")
elif age < 20:
    print("You're a teen!")
    
if age >= 18:
    print("You're an adult!")
