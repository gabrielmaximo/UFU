from primitives import *


screen_size = (800, 600)

# Variaveis de estilo
background = white
foreground = black

pygame.init()
window = pygame.display.set_mode(screen_size)

pygame.display.set_caption('Trabalho computacao grafica')
window.fill(background)
pygame.display.flip()

#Palletas 
# Cor 0
pygame.draw.rect(window, black, (0, 0, 50, 50))
# Cor 1
pygame.draw.rect(window, (169, 169, 169), (50, 0, 50, 50))
# Cor 2
pygame.draw.rect(window, (0, 0, 255), (100, 0, 50, 50))
# Cor 3
pygame.draw.rect(window, (255, 255, 0), (150, 0, 50, 50))
# Cor 4
pygame.draw.rect(window, (255, 0, 0), (200, 0, 50, 50))
# Cor 5
pygame.draw.rect(window, (0, 255, 0), (250, 0, 50, 50))
# Cor 6
pygame.draw.rect(window, (255, 105, 180), (300, 0, 50, 50))
# Cor 7
pygame.draw.rect(window, (255, 140, 0), (350, 0, 50, 50))
# Cor 8
pygame.draw.rect(window, (0, 191, 255), (400, 0, 50, 50))
# Cor 9
pygame.draw.rect(window, (255, 191, 0), (450, 0, 50, 50))
# Cor 10
pygame.draw.rect(window, (128, 0, 0), (500, 0, 50, 50))
# Cor 11
pygame.draw.rect(window, (138, 0, 138), (550, 0, 50, 50))
# Cor 12
pygame.draw.rect(window, (80, 200, 120), (600, 0, 50, 50))
# Cor 13
pygame.draw.rect(window, (190, 91, 89), (650, 0, 50, 50))
# Cor 14
pygame.draw.rect(window, (0, 139, 139), (700, 0, 50, 50))
# Cor 15
pygame.draw.rect(window, (166, 70, 62), (750, 0, 50, 50))

# interface:

bresenham2(window, 50, 50, 800, 50, black)
bresenham2(window, 50, 50, 50, 600, black)
#Moldura da janela
bresenham2(window,0,0,0,600,black)
bresenham2(window,0,0,800,0,black)
bresenham2(window,800,0,800,600,black)
bresenham2(window,0,600,800,600,black)


# para as primitivas
# linha
quadrado(window, 50, 50, 50, 100, black)
bresenham2(window, 10, 60, 40, 90, black)
# retângulo
quadrado(window, 50, 50, 100, 150, black)
retangulo(window, (10, 120), (40, 140), black)
# quadrado
quadrado(window, 50, 50, 150, 200, black)
quadrado(window, 10, 40, 160, 180, black)
# círculo
quadrado(window, 50, 50, 200, 250, black)
circulo(window,24,325,40,325,black)
# polilinha
quadrado(window, 50, 50, 300, 350, black)
bresenham2(window, 10, 260, 20, 280, black)
bresenham2(window, 20, 280, 30, 260, black)
bresenham2(window, 30, 260, 40, 280, black)
# spline ou bezier
quadrado(window, 50, 50, 250, 300, black)
bezier(window,(10,210),(20,240),(45,240),black)
# polilinha
quadrado(window, 50, 50, 300, 350, black)
bresenham2(window,10,260,20,280,black)
bresenham2(window,20,280,30,260,black)
bresenham2(window,30,260,40,280,black)

CorAtual = black
primitiva=0
controle=1#controle
while True:
    for event in pygame.event.get():

        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
        if event.type == pygame.MOUSEBUTTONDOWN:
            if event.button == 1:
                p1 = pygame.mouse.get_pos()
                if primitiva == 0:
                    if p1[0] > 0 and p1[1] > 50 and p1[0] < 50 and p1[1]<100:
                        primitiva=1#linha
                        continue
                    if p1[0] > 0 and p1[1]>100 and p1[0] <50 and p1[1]< 150:
                        primitiva=2#retangulo
                        continue
                    if p1[0]>0 and p1[1]>150 and p1[0]<50 and p1[1]<200:
                        primitiva=3#quadrado
                        continue
                    if p1[0]>0 and p1[1]>200 and p1[0]<50 and p1[1]<250:
                        primitiva=4#bezier
                        continue
                    if p1[0]>0 and p1[1]>250 and p1[0]<50 and p1[1]<300:
                        primitiva=5#polilinha
                        continue
                    if p1[0]>0 and p1[1]>300 and p1[0]<50 and p1[1]<350:
                        primitiva=6#circulo
                        continue
                if primitiva == 1:#linha
                    if controle ==1:
                        p2=pygame.mouse.get_pos()
                        controle+=1
                        continue
                    if controle ==2:
                        controle=1
                        bresenham(window,p1[0],p1[1],p2[0],p2[1],black)
                        primitiva =0
                        continue
                if primitiva == 2:#retangulo
                    if controle ==1:
                        p2=pygame.mouse.get_pos()
                        controle+=1
                        continue
                    if controle ==2:
                        controle=1
                        retangulo2(window,p1,p2,black)
                        primitiva=0
                        continue
                if primitiva ==3:#quadrado
                    if controle ==1:
                        p2=pygame.mouse.get_pos()
                        controle+=1
                        continue
                    if controle ==2:
                        controle=1
                        quadrado2(window,p1[0],p1[1],p2[0],p2[1],black)
                        primitiva=0
                        continue
                if primitiva ==4:#bezier
                    if controle ==1:
                        p2=pygame.mouse.get_pos()
                        controle+=1
                        continue
                    if controle==2:
                        p3=pygame.mouse.get_pos()
                        controle+=1
                        continue
                    if controle ==3:
                        controle=1
                        primitiva = 0
                        bezier2(window,p1,p3,p2,black)
                        continue
                if primitiva==5:#polilinha
                    if controle==1:
                        p2=pygame.mouse.get_pos()
                        controle+=1
                        bresenham(window,p1[0],p1[1],p2[0],p2[1],black)
                        p3=[0,0]
                        p3[0]=p2[0]
                        p3[1]=p2[1]
                        continue
                    if controle==2:
                        p2=pygame.mouse.get_pos()
                        bresenham(window,p3[0],p3[1],p2[0],p2[1],black)
                        p3[0]=p2[0]
                        p3[1]=p2[1]
                        if p2[0]>0 and p2[1]>50 and p2[0]<50 and p2[1]<600:
                            primitiva=0
                        continue
                if primitiva==6:#circulo
                    if controle==1:
                        p2=pygame.mouse.get_pos()
                        controle+=1
                        continue
                    if controle==2:
                        controle=1
                        circulo2(window,p1[0],p1[1],p2[0],p2[1],black)
                        primitiva=0
                        continue
pygame.display.update()