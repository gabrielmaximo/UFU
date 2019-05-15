import pygame
import math
import numpy
import sys

# Cores
white = (255, 255, 255)
black = (0, 0, 0)


#retangulo sem restrição
def retangulo(window, p1, p2,color):
    bresenham2(window, p1[0], p1[1], p2[0], p1[1], color)
    bresenham2(window, p1[0], p1[1], p1[0], p2[1], color)
    bresenham2(window, p1[0], p2[1], p2[0], p2[1], color)
    bresenham2(window, p2[0], p1[1], p2[0], p2[1], color)

#retangulo com restrição
def retangulo2(window, p1, p2,color):
    bresenham(window, p1[0], p1[1], p2[0], p1[1], color)
    bresenham(window, p1[0], p1[1], p1[0], p2[1], color)
    bresenham(window, p1[0], p2[1], p2[0], p2[1], color)
    bresenham(window, p2[0], p1[1], p2[0], p2[1], color)


#circulo sem restrição
def circulo(overlay, x0, y0, x1,y1, color):
    if y0 == y1:
            if x0 == x1:
                r=0
            if x0 > x1:
                r = x0 - x1
            else:
                r = x1 - x0
    elif x0 == x1:
        if x0 > x1:
            r = y0 - y1
        else:
            r = y1 - y0
    else:
        if y1 > y0 and x1 > x0:
            r = int(math.sqrt(((y1 - y0) * (y1 - y0)) + ((x1 - x0) * (x1 - x0))))
        elif y1 > y0 and x1 < x0:
            r = int(math.sqrt(((y1 - y0) * (y1 - y0)) + ((x0 - x1) * (x0 - x1))))
        elif y1 < y0 and x1 > x0:
            r = int(math.sqrt(((y0 - y1) * (y0 - y1)) + ((x0 - x1) * (x0 - x1))))
        else:
            r = int(math.sqrt(((y0 - y1) * (y0 - y1)) + ((x1 - x0) * (x1 - x0))))
    x = 0
    y = r
    d = 1 - r
    overlay.set_at((x + x0, y + y0), color)
    overlay.set_at((x0 - y, x + y0), color)
    overlay.set_at((x0 - y, y0 - x), color)
    overlay.set_at((x0 - x, y0 - y), color)
    overlay.set_at((x0 - x, y + y0), color)
    overlay.set_at((x + x0, y0 - y), color)
    overlay.set_at((y + x0, y0 - x), color)
    overlay.set_at((y + x0, x + y0), color)
    while y > x:
        if d < 0:
            d = d + (2 * x) + 3
        else:
            d = d + 2 * (x - y) + 5
            y = y - 1
        x = x + 1
        overlay.set_at((x + x0, y + y0), color)
        overlay.set_at((x0 - y, x + y0), color)
        overlay.set_at((x0 - y, y0 - x), color)
        overlay.set_at((x0 - x, y0 - y), color)
        overlay.set_at((x0 - x, y + y0), color)
        overlay.set_at((x + x0, y0 - y), color)
        overlay.set_at((y + x0, y0 - x), color)
        overlay.set_at((y + x0, x + y0), color)

#circulo com restrição
def circulo2(overlay, x0, y0, x1,y1, color):
    if y0 == y1:
            if x0 == x1:
                r=0
            if x0 > x1:
                r = x0 - x1
            else:
                r = x1 - x0
    elif x0 == x1:
        if x0 > x1:
            r = y0 - y1
        else:
            r = y1 - y0
    else:
        if y1 > y0 and x1 > x0:
            r = int(math.sqrt(((y1 - y0) * (y1 - y0)) + ((x1 - x0) * (x1 - x0))))
        elif y1 > y0 and x1 < x0:
            r = int(math.sqrt(((y1 - y0) * (y1 - y0)) + ((x0 - x1) * (x0 - x1))))
        elif y1 < y0 and x1 > x0:
            r = int(math.sqrt(((y0 - y1) * (y0 - y1)) + ((x0 - x1) * (x0 - x1))))
        else:
            r = int(math.sqrt(((y0 - y1) * (y0 - y1)) + ((x1 - x0) * (x1 - x0))))
    x = 0
    y = r
    d = 1 - r
    if (x+x0)>50 and (y+y0)>50 and (x+x0)<800 and (y+y0)<600:
        overlay.set_at((x + x0, y + y0), color)
    if (x0-y)>50 and (x+y0)>50 and (x0-y)<800 and (x+y0)<600:
        overlay.set_at((x0 - y, x + y0), color)
    if (x0-y)>50 and (y0-x)>50 and (x0-y)<800 and (y0-x)<600:
        overlay.set_at((x0 - y, y0 - x), color)
    if (x0 -x)>50 and (y0-y)>50 and (x0 - x)<800 and (y0-y)<600:
        overlay.set_at((x0 - x, y0 - y), color)
    if (x0-x)>50 and (y+y0)>50 and (x0-x)<800 and (y0+y)<600:
        overlay.set_at((x0 - x, y + y0), color)
    if (x+x0)>50 and (y0-y)>50 and (x+x0)<800 and (y0-y)<600:
        overlay.set_at((x + x0, y0 - y), color)
    if (y+x0)>50 and (y0 -x)>50 and (y+x0)<800 and (y0-x):
        overlay.set_at((y + x0, y0 - x), color)
    if (y+x0)>50 and (x+y0)>50 and (y+x0)<800 and (x+y0):
        overlay.set_at((y + x0, x + y0), color)
    while y > x:
        if d < 0:
            d = d + (2 * x) + 3
        else:
            d = d + 2 * (x - y) + 5
            y = y - 1
        x = x + 1
        if (x + x0) > 50 and (y + y0) > 50 and (x + x0) < 800 and (y + y0) < 600:
            overlay.set_at((x + x0, y + y0), color)
        if (x0 - y) > 50 and (x + y0) > 50 and (x0 - y) < 800 and (x + y0) < 600:
            overlay.set_at((x0 - y, x + y0), color)
        if (x0 - y) > 50 and (y0 - x)>50 and (x0 - y) < 800 and (y0 - x) < 600:
            overlay.set_at((x0 - y, y0 - x), color)
        if (x0 - x) > 50 and (y0 - y) > 50 and (x0 - x) < 800 and (y0 - y) < 600:
            overlay.set_at((x0 - x, y0 - y), color)
        if (x0 - x) > 50 and (y + y0) > 50 and (x0 - x) < 800 and (y0 + y) < 600:
            overlay.set_at((x0 - x, y + y0), color)
        if (x + x0) > 50 and (y0 - y) > 50 and (x + x0) < 800 and (y0 - y) < 600:
            overlay.set_at((x + x0, y0 - y), color)
        if (y + x0) > 50 and (y0 - x) > 50 and (y + x0) < 800 and (y0 - x):
            overlay.set_at((y + x0, y0 - x), color)
        if (y + x0) > 50 and (x + y0) > 50 and (y + x0) < 800 and (x + y0):
            overlay.set_at((y + x0, x + y0), color)


#bresenham sem restrição
def bresenham2(screen, x1, y1, x2, y2, color):

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
                screen.set_at((x, y), color)#sem re

#bresenham com restrições
def bresenham(screen, x1, y1, x2, y2, color):
    if x2 >= x1:
        dx = (x2 - x1)  # estabelecimento do modulo de dx
        incx = 1  # da esquerda para a direita
    else:
        dx = (x1 - x2)
        incx = -1

    if y2 >= y1:
        dy = (y2 - y1)  # modulo de dy
        incy = 1  # de baixo para cima
    else:
        dy = (y1 - y2)
        incy = -1  # de cima para baixo
    x = x1
    y = y1
    if x1>=50 and y1>=50 and x1<=800 and y1<=600:
        screen.set_at((x1, y1), color)

    if dx == 0:
        if incy > 0:
            for y in range(y1, y2):  # Nao tenho ctz
                if x>=50 and y>=50 and x<=800 and y<=600: #garantir que esteja dentro da area de desenho
                    screen.set_at((x, y), color)
        else:
            for y in range(y2, y1):
                if x >= 50 and y >= 50 and x <= 800 and y <= 600:  # garantir que esteja dentro da area de desenho
                    screen.set_at((x, y), color)
    elif dy == 0:
        if incx > 0:
            for x in range(x1, x2):
                if x >= 50 and y >= 50 and x <= 800 and y <= 600:  # garantir que esteja dentro da area de desenho
                    screen.set_at((x, y), color)
        else:
            for x in range(x2, x1):
                if x >= 50 and y >= 50 and x <= 800 and y <= 600:  # garantir que esteja dentro da area de desenho
                    screen.set_at((x, y), color)
    else:
        if dx >= dy:
            d = (2 * dy - dx)
            incE = 2 * dy
            incNE = 2 * (dy - dx)
            while x != x2:
                if d <= 0:
                    d = d + incE
                    x = x + incx
                else:
                    d = d + incNE
                    x = x + incx
                    y = y + incy
                if x >= 50 and y >= 50 and x <= 800 and y <= 600:  # garantir que esteja dentro da area de desenho
                    screen.set_at((x, y), color)
        else:
            d = (2 * dx - dy)
            incE = 2 * dx
            incNE = 2 * (dx - dy)
            while y != y2:
                if d <= 0:
                    d = d + incE
                    y = y + incy
                else:
                    d = d + incNE
                    y = y + incy
                    x = x + incx
                if x >= 50 and y >= 50 and x <= 800 and y <= 600:  # garantir que esteja dentro da area de desenho
                    screen.set_at((x, y), color)


#quadrado sem restrição
def quadrado(window, x1, x2, y1, y2, color):
    if y1 == y2 or x1 == x2:
        if x1 == x2:
            if x1 > x2:
                distancia = y2 - y1
            else:
                distancia = y1 - y2

            bresenham2(window, x2, y2, x2 + distancia, y2, color)
            bresenham2(window, x2, y2, x2, y2 + distancia, color)
            bresenham2(window, x2 + distancia, y2, x2 + distancia, y2 + distancia, color)
            bresenham2(window, x2, y2 + distancia, x2 + distancia, y2 + distancia, color)
        elif y1 == y2:
            if y1 > y2:
                distancia = x2 - x1
            else:
                distancia = x1 - x2

            bresenham2(window, x2, y2, x2 + distancia, y2, color)
            bresenham2(window, x2, y2, x2, y2 + distancia, color)
            bresenham2(window, x2 + distancia, y2, x2 + distancia, y2 + distancia, color)
            bresenham2(window, x2, y2 + distancia, x2 + distancia, y2 + distancia, color)
    else:
        if y2 > y1 and x2 > x1:
            distancia = int(
                math.sqrt(((y2 - y1) * (y2 - y1)) + ((x2 - x1) * (x2 - x1))))
            bresenham2(window, x1, y1, x1 + distancia, y1, color)
            bresenham2(window, x1, y1, x1, y1 + distancia, color)
            bresenham2(window, x1 + distancia, y1, x1 + distancia, y1 + distancia, color)
            bresenham2(window, x1, y1 + distancia, x1 + distancia, y1 + distancia, color)
        elif y2 > y1 and x2 < x1:
            distancia = int(
                math.sqrt(((y2 - y1) * (y2 - y1)) + ((x1 - x2) * (x1 - x2))))
            bresenham2(window, x1, y1, x1 - distancia, y1, color)
            bresenham2(window, x1, y1, x1, y1 + distancia, color)
            bresenham2(window, x1 - distancia, y1, x1 - distancia, y1 + distancia, color)
            bresenham2(window, x1, y1 + distancia, x1 - distancia, y1 + distancia, color)
        elif y2 < y1 and x2 > x1:
            distancia = int(
                math.sqrt(((y1 - y2) * (y1 - y2)) + ((x1 - x2) * (x1 - x2))))
            bresenham2(window, x1, y1, x1 + distancia, y1, color)
            bresenham2(window, x1, y1, x1, y1 - distancia, color)
            bresenham2(window, x1 + distancia, y1, x1 + distancia, y1 - distancia, color)
            bresenham2\
                (window, x1, y1 - distancia, x1 + distancia, y1 - distancia, color)
        else:
            distancia = int(
                math.sqrt(((y1 - y2) * (y1 - y2)) + ((x2 - x1) * (x2 - x1))))
            bresenham2(window, x1, y1, x1 - distancia, y1, color)
            bresenham2(window, x1, y1, x1, y1 - distancia, color)
            bresenham2(window, x1 - distancia, y1, x1 - distancia, y1 - distancia, color)
            bresenham2(window, x1, y1 - distancia, x1 - distancia, y1 - distancia, color)


#quadrado com restrições
def quadrado2(window, x1, y1, x2, y2, color):
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
            distancia = int(
                math.sqrt(((y2 - y1) * (y2 - y1)) + ((x1 - x2) * (x1 - x2))))
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


#bezier sem restrição
def bezier(window, p1, p2, p3, color):
    for t in numpy.arange(0, 1, 0.005):
        omt = 1 - t
        omt2 = omt * omt
        omt3 = omt2 * omt
        t2 = t * t
        t3 = t2 * t
        x = omt3 * p1[0] + ((3 * omt2) * t * p1[0]) + (3 * omt * t2 * p2[0]) + t3 * p3[0]
        y = omt3 * p1[1] + ((3 * omt2) * t * p1[1]) + (3 * omt * t2 * p2[1]) + t3 * p3[1]
        x = int(numpy.floor(x))
        y = int(numpy.floor(y))

        window.set_at((x, y), color)
    pygame.display.flip()


#bezier com restrições
def bezier2(window, p1, p2, p3, color):
    for t in numpy.arange(0, 1, 0.005):
        omt = 1 - t
        omt2 = omt * omt
        omt3 = omt2 * omt
        t2 = t * t
        t3 = t2 * t
        x = omt3 * p1[0] + ((3 * omt2) * t * p1[0]) + (3 * omt * t2 * p2[0]) + t3 * p3[0]
        y = omt3 * p1[1] + ((3 * omt2) * t * p1[1]) + (3 * omt * t2 * p2[1]) + t3 * p3[1]
        x = int(numpy.floor(x))
        y = int(numpy.floor(y))

        if x>50 and y>50 and y<800 and x<600:
            window.set_at((x, y), color)
    pygame.display.flip()
