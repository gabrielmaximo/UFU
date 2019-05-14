import pygame
import math

# Cores
white = (255, 255, 255)
black = (0, 0, 0)


def retangulo(window, x1, y1, x2, y2, color):
    bresenham(window, x1, y1, x2, y1, color)
    bresenham(window, x1, y1, x1, y2, color)
    bresenham(window, x1, y2, x2, y2, color)
    bresenham(window, x2, y1, x2, y2, color)


def bresenham(screen, x1, y1, x2, y2, color):

    if x2 >= x1:
        dx = (x2-x1)  # estabelecimento do modulo de dx
        incx = 1  # da esquerda para a direita
    else:
        dx = (x1-x2)
        incx = -1

    if y2 >= y1:
        dy = (y2-y1)  # modulo de dy
        incy = 1  # de baixo para cima
    else:
        dy = (y1-y2)
        incy = -1  # de cima para baixo
    x = x1
    y = y1
    screen.set_at((x1, y1), color)

    if dx == 0:
        if incy > 0:
            for y in range(y1, y2):  # Nao tenho ctz
                screen.set_at((x, y), color)
        else:
            for y in range(y2, y1):
                screen.set_at((x, y), color)
    elif dy == 0:
        if incx > 0:
            for x in range(x1, x2):
                screen.set_at((x, y), color)
        else:
            for x in range(x2, x1):
                screen.set_at((x, y), color)
    else:
        if dx >= dy:
            d = (2*dy-dx)
            incE = 2*dy
            incNE = 2*(dy-dx)
            while x != x2:
                if d <= 0:
                    d = d+incE
                    x = x+incx
                else:
                    d = d+incNE
                    x = x+incx
                    y = y+incy
                screen.set_at((x, y), color)
        else:
            d = (2*dx-dy)
            incE = 2*dx
            incNE = 2*(dx-dy)
            while y != y2:
                if d <= 0:
                    d = d+incE
                    y = y+incy
                else:
                    d = d+incNE
                    y = y+incy
                    x = x+incx
                screen.set_at((x, y), color)


def quadrado(window, x1, x2, y1, y2, color):
    if y1 == y2 or x1 == x2:
        if x1 == x2:
            if x1 > x2:
                distancia = y2-y1
            else:
                distancia = y1-y2

            bresenham(window, x2, y2, x2+distancia, y2, color)
            bresenham(window, x2, y2, x2, y2+distancia, color)
            bresenham(window, x2+distancia, y2, x2+distancia, y2+distancia, color)
            bresenham(window, x2, y2+distancia, x2+distancia, y2+distancia, color)
        elif y1 == y2:
            if y1 > y2:
                distancia = x2-x1
            else:
                distancia = x1-x2

            bresenham(window, x2, y2, x2 + distancia, y2, color)
            bresenham(window, x2, y2, x2, y2 + distancia, color)
            bresenham(window, x2 + distancia, y2, x2 + distancia, y2 + distancia, color)
            bresenham(window, x2, y2 + distancia, x2 + distancia, y2 + distancia, color)
    else:
        if y2 > y1 and x2 > x1:
            distancia = int(
                math.sqrt(((y2-y1)*(y2-y1))+((x2-x1)*(x2-x1))))
            bresenham(window, x1, y1, x1 + distancia, y1, color)
            bresenham(window, x1, y1, x1, y1 + distancia, color)
            bresenham(window, x1 + distancia, y1, x1 + distancia, y1 + distancia, color)
            bresenham(window, x1, y1 + distancia, x1 + distancia, y1 + distancia, color)
        elif y2 > y1 and x2 < x1:
            distancia = int(math.sqrt(((y2 - y1) * (y2 - y1)) + ((x1 - x2) * (x1 - x2))))
            bresenham(window, x1, y1, x1 - distancia, y1, color)
            bresenham(window, x1, y1, x1, y1 + distancia, color)
            bresenham(window, x1 - distancia, y1, x1 - distancia, y1 + distancia, color)
            bresenham(window, x1, y1 + distancia, x1 - distancia, y1 + distancia, color)
        elif y2 < y1 and x2 > x1:
            distancia = int(
                math.sqrt(((y1 - y2) * (y1 - y2)) + ((x1 - x2) * (x1 - x2))))
            bresenham(window, x1, y1, x1 + distancia, y1, color)
            bresenham(window, x1, y1, x1, y1 - distancia, color)
            bresenham(window, x1 + distancia, y1, x1 + distancia, y1 - distancia, color)
            bresenham(window, x1, y1 - distancia, x1 + distancia, y1 - distancia, color)
        else:
            distancia = int(
                math.sqrt(((y1 - y2) * (y1 - y2)) + ((x2 - x1) * (x2 - x1))))
            bresenham(window, x1, y1, x1 - distancia, y1, color)
            bresenham(window, x1, y1, x1, y1 - distancia, color)
            bresenham(window, x1 - distancia, y1, x1 - distancia, y1 - distancia, color)
            bresenham(window, x1, y1 - distancia, x1 - distancia, y1 - distancia, color)
