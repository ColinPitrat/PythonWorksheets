for i in range(256):
    print("%s: %s\t" % (i, chr(i)), end='')
    if i % 16 == 15:
        print()
