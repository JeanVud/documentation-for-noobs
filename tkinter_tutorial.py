from tkinter import *

# INTRO
root = Tk()

theLabel = Label(root,text='This is too easy')
theLabel.pack()

# ORGANIZING YOUR LAYOUT
topframe = Frame (root)
topframe.pack()
bottomframe = Frame(root)
bottomframe.pack(side=BOTTOM)

button1 = Button(topframe, text = 'Button 1', fg='red')
button2 = Button(topframe, text = 'Button 2', fg='blue')
button3 = Button(topframe, text = 'Button 3', fg='green')
button4 = Button(bottomframe, text = 'Button 4', fg='purple')

button1.pack(side=LEFT)
button2.pack(side=LEFT)
button3.pack(side=LEFT)
button4.pack(side=BOTTOM)



# fitting widgets in your layout

one = Label(root, text='one', bg='red', fg='white')
one.pack()
two = Label(root, text='two', bg='green', fg='black')
two.pack(fill=X)
three = Label(root, text='three', bg='blue', fg='white')
one.pack(side=LEFT, fill=Y)

# grid layout
label_1 = Label(root,text='Name')
label_2 = Label(root,text='Password').grid(row=1, sticky=E)
entry_1 = Entry(root)
entry_2 = Entry(root,width=50).grid(row=1, column =1)

label_1.grid(row=0, sticky=E)   # sticky=E: right-aligned

entry_1.grid(row=0, column =1)

c = CheckButton(root, text="Keep me logged in")
c.grid(columnspan=2)

# Binding Functions to Layouts

def printName(event):
    print("chello my name is Jean!")

button_1 = Button(root, text='Print my name')
button_1.pack()
button_1.bind("<Button-1>",printName)

# Mouse click events

def leftClick(event):
    print("Left")
def middleClick(event):
    print("middle")
def rightClick(event):
    print("right")

frame = Frame(root, width=300, height=250)
frame.bind("<Button-1>",leftClick)
frame.bind("<Button-2>",middleClick)
frame.bind("<Button-3>",rightClick)
frame.pack()

# Using Classes

class BuckysButton:
    def __init__(self,master):
        frame = Frame(master)
        frame.pack()

        self.printButton = Button(frame, text="Print Message",
                        command = self.printMessage)
        self.printButton.pack(side=LEFT)

    def printMessage(self):
        print("Wow, this actually worked!")

root = Tk()
b = BuckysButton(root)

# Creating Drop Down Menus

def doNothing():
    print("ok ok i wont...")

root = Tk()
menu = Menu(root)
root.config(menu = menu)

subMenu = Menu(menu)
menu.add_cascade(label='File', menu=subMenu)
subMenu.add_command(label='New project...', command=doNothing)
subMenu.add_command(label='New...', command=doNothing)
subMenu.add_separator()
subMenu.add_command(label='Exit...', command=root.quit)

# Creating a toolbar

toolbar = Frame(root, bg='blue')

insertButton = Button(toolbar, text='Insert Image', command=doNothing)
insertButton.pack(side=LEFT, padx=2, pady=2)
printButton = Button(toolbar, text='Print', command=doNothing)
insertButton.pack(side=LEFT, padx=2, pady=2)

toolbar.pack(side=TOP, fill=X)

def myClick():
    myLabel = Label(root, text="Look! I clicked a button!")
    myLabel.pack()

myButton = Button(root, text='Click me', command=myClick, fg='blue', bg='#ffffff')
myButton.pack()

# Creating the status bar

status = Label(root, text='Preparing to do nothing...', bd=1, relief=SUNKEN, anchor=W)
status.pack(side=BOTTOM, fill=X)

# Creating the messagebox

tkinter.messagebox.showinfo('Window Title','Monkeys can live very long')
answer = tkinter.messagebox.askquestion('Question 1', 'Do you like silly faces?')

if answer == 'yes':
    print(' 8===D')

# Shapes and graphics with Canvas

canvas = Canvas(root, width=200, height=100)
canvas.pack()

blackLine = canvas.create_line(0,0,200,50)
redLine  = canvas.create_line(0,100,200,50, fill='red')
greenBox = canvas.create_rectangle(25,25,130,60, fill='green')

canvas.delete(redLine)
canvas.delete(ALL)

# Images and Icons

photo = PhotoImage(file='tomsface.png')
label = Label(root, image=photo)
label.pack()

# Input Fields lambda
#passing variables to functions

entry = Entry(root, width=40)
entry.pack()
entry.insert(0, 'Enter your name: ') #insert text into entry
                                # 0 is index,
                                # 'enter your name' is default
entry.delete(0,END)                    #resets entry to empty
entry.bind("<FocusIn>", lambda args: name_entry.delete('0', 'end')) #bind a function to the entry widgets  
                                # clears placeholder text to enter text


def myClickie():
    myLabel = Label(root, text = "Hello "+e.get())
    myLabel.pack()

myButton = Button(root, text='Enter your Name', command=myClickie)
myButton.pack()

def printResult(text):
    temp = Label(root, text=text).pack()

button = Button(root,text='click me',
            command=lambda: printResult(e.get()) ).pack()

def refreshEntry(): #resets entry to empty
    e.delete(0,END)
refreshButton = Button(root, text='Clear entry',command=refreshEntry)


root.mainloop()
