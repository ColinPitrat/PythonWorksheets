#import "../../template.typ": *

#show: doc => cs_sheet(
  title: "1. Basic Maths - Variables - Input",
  lang: "en",
  doc,
)

= Starting Python

Python is a programming language. It allows to make a computer do anything we want, as long as we know how to ask for it. Python comes with an IDE called IDLE which we’re going to use here.

To start it, find the IDLE icon on the desktop or in the application menu.  It should look like this: #box(image("../../resources/icons/python.svg", height: 1em))

= Basic Maths

When IDLE start, you should see something like this:
#image("../../resources/screenshots/idle_start.png")

This is what we call a shell, or also a REPL (for #strong[R]ead #strong[E]val #strong[P]rint #strong[L]oop).

You can type commands after the `>>>` and they will be executed immediately.

Try typing things like:

```
3+4
12-3
10*5
100/20
(10*5)+7
```

#experiment[
Try doing other operations. Can you trick the computer? Can you obtain surprising results? Do you understand everything that happens?
]

= Variables

You can store results of your computations in variables. This is a nice way to put a name on something to reuse it later.

Try typing this:
```
a = 3+4
b = 12-3
c = a+b
```

What happens? What’s different?

#block(breakable: false)[
Now try:
```
c
```
]

= Input

To finish this session let’s see how the computer can read something from you:
```
name = input(“What’s your name?”)
```

And then:
```
“Hello, %s” % name
```

= Practice

Let's put what you learned in practice.

== Factorials

In mathematics, the factorial of a number is what you get when you multiply this number by all the numbers that are smaller than it, down to 1. It's written by putting a `!` after the number.
So for example, $4! = 4 times 3 times 2 times 1$

Compute $10!$ using python.

== More factorials, faster

In the shell, you can recall the previous command with `Alt + P`.

We'll print factorials of numbers faster. In python, we can put multiple statements on the same line if we separate them with a semicolon `;`.
Type:
```
n=1; r=1
r=r*n; n=n+1; r
```

Then press `Alt + P` followed by `Enter`. Repeat that as many times as you want.

#experiment[
It's growing fast isn't it? Can you find a way to make the numbers grow even faster? Can you get to the point where "something breaks"? When this happens, read carefully the error. Can you find a way to go even further?
]
