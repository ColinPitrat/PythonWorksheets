#import "../template.typ": *

#show: doc => cs_sheet(
  title: "2. Functions - If statements",
  lang: "en",
  doc,
)

= Functions

A function is a way to define a piece of code that can e reused. It can take some parameters and return a value.

Try this:

#grid(
  columns: (1fr, 30%),
  gutter: 20pt,
  align: horizon,
  [
    ```
    def greetings(name):
      print("Hello %s" % name)

    greetings("Richard")
    greetings("Elizabeth")
    ```
  ],
  image("../../resources/screenshots/function-definition-en.png", width: 100%)
)

Notice how IDLE shows `...` instead of `>>>` when it’s waiting for you to type the function content (which is called the *function body*) and how it automatically adds some spaces before the lines (called *indentation*).

Note also that we used `print` to display the message. A function can also return something. Our `greetings` function doesn’t return anything, but this one does:

```
def pythonista(name):
    return “%s is a pythonista” % name

pythonista(“Guido”)
```

Function are very important, so let’s look at another example. This one takes multiple parameters and returns something too.

```
def mix(a, b, c):
    return a*b + b*c + c*a

mix(1, 2, 3)
```

= If statements

Sometimes, you want your code to do different things depending on some condition. One way to do this is with `if` statements. To make it easier to experiment, let’s put them in functions, though they don’t need to be:

```
def greet(name, age):
    print(“Hello %s” % name)
    if age > 18:
        print(“I see you’re an adult”)

greet(“Mariet”, 21)
greet(“Hugo”, 9)
```

#find_bug[
You might just have written your first bug! A bug is an error in a program. Can you find it?
]

You can also add an `else` after an `if`:

```
def tell_secret(password):
    if password == “abc123”:
        print(“The secret is that ”)
    else:
        print(“Sorry, I can’t tell you the secret”)
```

#experiment[
You can also use `elif` if you want to do something when the condition of the `if` is not met but another is. Can you figure out how to use it?
]

= Practice

Let's put what you learned in practice.

== Roller coaster

A theme park owner charged you with implementing an automatic check for the access to a roller coaster. The rules are:
 - You must be at least 110cm to access the ride
 - If you're less than 150cm, you must be with an adult

Write a function `can_ride(size, accompanied)` such that you get the following result when using it:

#grid(
  columns: (1fr, 50%),
  gutter: 20pt,
  align: horizon,
  [
    ```
    >>> can_ride(100, False)
        False
    >>> can_ride(100, True)
        False
    >>> can_ride(110, True)
        True
    ```
  ],
  [
    ```
    >>> can_ride(110, False)
        False
    >>> can_ride(150, True)
        True
    >>> can_ride(150, False)
        True
    ```
  ]
)

== Taste emulator

Write a function that will predict your reaction to various food.
For example, mine looks like this:

#grid(
  columns: (1fr, 50%),
  gutter: 20pt,
  align: horizon,
  [
    ```
    >>> feed_me("Tiramisu")
        "Yummy 😋"
    >>> feed_me("Hot chocolate")
        "Yummy 😋"
    >>> feed_me("Jellies")
        "Yuck, no thanks! 🤢"
    ```
  ],
  [
    ```
    >>> feed_me("Pasta")
        "Oh yes, I'm hungry. 🍴"
    >>> feed_me("Dog poo")
        "I don't know about that 🤷"
    >>> feed_me("Noodles")
        "I don't know about that 🤷"
    ```
  ]
)

== Rectangles

Write:
 - a function that computes the area of a rectangle
 - a function that computes the perimeter of a rectangle
 - a function that tells you if a rectangle is equable (its area equals its permieter)

All these functions should take width and height as parameter.

For example:
#grid(
  columns: (1fr, 50%),
  gutter: 20pt,
  align: horizon,
  [
    ```
    >>> area(5, 4)
        20
    >>> perimeter(5, 4)
        18
    >>> equable(5, 4)
        False
    ```
  ],
  [
    ```
    >>> area(6, 3)
        18
    >>> perimeter(6, 3)
        18
    >>> equable(6, 3)
        True
    ```
  ]
)
