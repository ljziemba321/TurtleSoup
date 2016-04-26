import turtle
wn = turtle.Screen()
wn.bgcolor("red")
arlo = turtle.Turtle()
arlo.shape("turtle")
arlo.color("green")
arlo.speed(1)
lilo = turtle.Turtle()
lilo.shape("turtle")
lilo.color("green")
lilo.speed(1)
arlo.forward(100)
arlo.penup()
lilo.left(45)
lilo.forward(75 + 20)
x = 100
arlo.left(100)
lilo.color("blue")
lilo.right(90)
lilo.forward(x)
y = x - 45
arlo.right(y)
arlo.forward(50)
x = 200
arlo.pendown()
for i in range(0, 10):
	x = x - 20
	arlo.left(90)
	lilo.left(x)
	arlo.forward(x)
	lilo.forward(x / 2)
