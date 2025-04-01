action = None
while action not in ["e", "d"]:
    action = input("Do you want to encode or decode (e/d)? ")

prefix = ""
if action == "e":
    prefix = "encoded"
    shift = 3
elif action == "d":
    prefix = "decoded"
    shift = -3
else:
    raise Exception("Unsupported action '%s'" % action)

message = input("What’s your message? ")
result = ""


def apply_shift(idx, low, high, shift):
    if idx >= low and idx <= high:
        span = (high - low) + 1
        idx += shift
        if idx > high:
            idx -= span
        elif idx < low:
            idx += span
    return idx


for c in message:
    idx = ord(c)
    idx = apply_shift(idx, ord('A'), ord('Z'), shift)
    idx = apply_shift(idx, ord('a'), ord('z'), shift)
    idx = apply_shift(idx, ord('0'), ord('9'), shift)
    result += chr(idx)
    
print("%s message: %s" % (prefix, result))
