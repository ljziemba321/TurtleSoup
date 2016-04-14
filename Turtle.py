import turtle

wn = turtle.Screen()
wn.bgcolor("skyblue")
wn.title("Hello, Tom!")
arlo = turtle.Turtle()
arlo.shape("turtle")
lilo = turtle.Turtle()
lilo.shape("turtle")

arlo.forward(50)
lilo.left(90)
lilo.forward(100)
while(1):
	arlo.right(0)

wn.mainloop()

