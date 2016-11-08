
#from usingpython.com
import tkinter, random #import the modules we need, for creating a GUI...

#the list of possible colour.
colours = ['Red','Blue','Green','Pink','Black','Yellow','Orange','White','Purple','Brown']
score=0 #the player's score, initially 0.
timeleft=30 #the game time left, initially 30 seconds.
timeSet = int(input("input the time in integers > ")) #let's user set time for the game
def startGame(event): #a function that will start the game.

    if timeleft == timeSet: #if there's still time left...
        countdown()

    nextColour() #run the function to choose the next colour.

def nextColour(): #function to choose and display the next colour.
    global score, timeleft

    if timeleft > 0:
        e.focus_set() #...make the text entry box active.
        if e.get().lower() == colours[1].lower(): #if the colour typed is equal to the colour of the text...
            score += 1

        e.delete(0, tkinter.END) #clear the text entry box.
        random.shuffle(colours) #shuffle the list of colours.
        #change the colour to type, by changing the text _and_ the colour to a random colour value
        label.config(fg=str(colours[1]), text=str(colours[0]))
        scoreLabel.config(text="Score: " + str(score)) #update the score.

def countdown(): #a countdown timer function.

    global timeleft #use the globally declared 'play' variable above.

    if timeleft > 0: #if a game is in play...
        timeleft -= 1
        timeLabel.config(text="Time left: " + str(timeleft)) #update the time left label.
        timeLabel.after(1000, countdown) #run the function again after 1 second.

root = tkinter.Tk() #create a GUI window.
root.title("TTCANTW") #set the title.
root.geometry("400x250") #set the window size.

font = 'Verdana', 14
#add an instructions label.
instructions = tkinter.Label(root, text="Type in the colour of the words, and not the word text!", font=(font))
instructions.pack()
#add a score label.
scoreLabel = tkinter.Label(root, text="Press enter to start", font=(font))
scoreLabel.pack()
#add a time left label.
timeLabel = tkinter.Label(root, text="Time left: " + str(timeleft), font=(font))
timeLabel.pack()
#add a label for displaying the colours.
label = tkinter.Label(root, font=('Verdana', 60))
label.pack()

e = tkinter.Entry(root) #add a text entry box for typing in colours.
root.bind('<Return>', startGame) #run the 'startGame' function when the enter key is pressed.
e.pack()
e.focus_set() #set focus on the entry box.
root.mainloop() #start the GUI
