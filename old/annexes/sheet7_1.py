numbers = []
while True:
    value = input("Enter a number: ")
    if value == "quit":
        break
    numbers.append(int(value))

print("You gave me these numbers: %s" % numbers)
print("Their sum is: %s" % sum(numbers))
if len(numbers) > 0:
    print("The smallest is: %s" % min(numbers))
    print("The biggest is: %s" % max(numbers))
    print("First element: %s – Last element: %s" % (numbers[0], numbers[-1]))
if len(numbers) >= 3:
	print("First three elements: %s" % numbers[:3])
	print("Last three elements: %s" % numbers[-3:])

for i in range(len(numbers)):
	numbers[i] += 1

print("After adding one to each number: %s" % numbers)

numbers.sort()
print("After sorting the list: %s" % numbers)
