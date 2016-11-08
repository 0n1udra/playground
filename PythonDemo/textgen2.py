# More programs at: usingpython.com/programs
import string, random, time
possibleCharacters, completed, generation, attemptNext = string.printable, False, 0, ''
target = input("Enter your target text: ")
attemptThis = ''.join(random.choice(possibleCharacters) for i in range(len(target)))
while completed == False:
    print(attemptThis)
    attemptNext = ''
    completed = True
    for i in range(len(target)):
        if attemptThis[i] != target[i]:
            completed = False
            attemptNext += random.choice(possibleCharacters)
        else: attemptNext += target[i]
    generation += 1
    attemptThis = attemptNext
print("Match > " + str(generation) + " generation(s)")