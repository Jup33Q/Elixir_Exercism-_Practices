def is_triangle(sides):
    a, b, c = sorted(sides)
    return a + b > c and a > 0 and b > 0 and c > 0

def equilateral(sides):
    return len(set(sides))==1 and is_triangle(sides)


def isosceles(sides):
    return len(set(sides))<=2 and is_triangle(sides)


def scalene(sides):
    return len(set(sides))==3 and is_triangle(sides)
