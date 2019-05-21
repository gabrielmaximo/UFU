from primitives import *


screen_size = (800, 600)

def flood_Fill(surface, x, y, newColor):
    pilha = [(x, y)]
    corOriginal = surface.get_at((x, y))  # cor de fundo original

    while len(pilha) > 0:
        x, y = pilha.pop()

        #        if((x < 0 or x>900) or (y<100 or y>600)):
        #            continue
        if surface.get_at((x, y)) != corOriginal:
            continue
        surface.set_at((x, y), newColor)
        # pygame.display.update()
        if ((x + 1) <= 799):
            pilha.append((x + 1, y))  # poe o pixel da direita na pilha para ser preenchido
        if ((x - 1) >= 0):
            pilha.append((x - 1, y))  # poe o pixel da esquerda na pilha para ser preenchido
        if ((y + 1) <= 599):
            pilha.append((x, y + 1))  # poe o pixel de baixo na pilha para ser preenchido
        if ((y - 1) >= 50):
            pilha.append((x, y - 1)) # poe o pixel de cima na pilha para ser preenchido

# Variaveis de estilo
background = white
foreground = black

pygame.init()
window = pygame.display.set_mode(screen_size)

pygame.display.set_caption('Trabalho computacao grafica')
window.fill(background)
pygame.display.flip()

# Cor 0
quadrado(window, 0, 50, 50, 50, black)
flood_Fill(window,10,1,black)#preenche com preto
# Cor 1
quadrado(window, 50, 100, 50, 50, black)
flood_Fill(window,60,1,(169,169,169))#preenche com cinza
# Cor 2
quadrado(window, 100, 150, 50, 50, black)
flood_Fill(window,110,1,(0,0,255))#preenche com azul
# Cor 3
quadrado(window, 150, 200, 50, 50, black)
flood_Fill(window,160,1,(255,255,0))#preenche com amarelo
# Cor 4
quadrado(window, 200, 250, 50, 50, black)
flood_Fill(window,210,1,red)#preenche com vermelho
# Cor 5
quadrado(window, 250, 300, 50, 50, black)
flood_Fill(window,260,1,(0,255,0))#preenche com verde
# Cor 6
quadrado(window, 300, 350, 50, 50, black)
flood_Fill(window,310,1,(255,105,180))#preenche com rosa
# Cor 7
quadrado(window, 350, 400, 50, 50, black)
flood_Fill(window,360,1,(255,140,0))#preenche com laranja
# Cor 8
quadrado(window, 400, 450, 50, 50, black)
flood_Fill(window,410,1,(0, 191, 255))#preenche com ciano
# Cor 9
quadrado(window, 450, 500, 50, 50, black)
flood_Fill(window,460,1,(255, 191, 0))#preenche com amarelo escuro
# Cor 10
quadrado(window, 500, 550, 50, 50, black)
flood_Fill(window,510,1,(128, 0, 0))#preenche com marrom escuro
# Cor 11
quadrado(window, 550, 600, 50, 50, black)
flood_Fill(window,560,1,(138, 0, 138))#preenche com roxo
# Cor 12
quadrado(window, 600, 650, 50, 50, black)#preenche com verde agua
flood_Fill(window,610,1,(80, 200, 120))
# Cor 13
quadrado(window, 650, 700, 50, 50, black)#preenche com rosa cor de pele
flood_Fill(window,660,1,(190, 91, 89))
# Cor 14
quadrado(window, 700, 750, 50, 50, black)#preenche com azul esverdeado
flood_Fill(window,710,1,(0, 139, 139))
# Cor 15
quadrado(window, 750, 800, 50, 50, black)#preenche com marrom rosa
pygame.draw.rect(window,(166,70,62),(751,0,49,50))

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
                    if p1[0]>0 and p1[1]>0 and p1[0]<50 and p1[1]<50:
                        primitiva=7#preencher com preto
                        continue
                    if p1[0]>50 and p1[1]>0 and p1[0]<100 and p1[1]<50:
                        primitiva=8#preenche com cinza
                        continue
                    if p1[0]>100 and p1[1]>0 and p1[0]<150 and p1[1]<50:
                        primitiva=9#preenche com azul
                        continue
                    if p1[0]>150 and p1[1]>0 and p1[0]<200 and p1[1]<50:
                        primitiva=10#preenche com amarelo
                        continue
                    if p1[0]>200 and p1[1]>0 and p1[0]<250 and p1[1]<50:
                        primitiva=11#preenche com vermelho
                        continue
                    if p1[0]>250 and p1[1]>0 and p1[0]<300 and p1[1]<50:
                        primitiva=12#preenche com verde
                        continue
                    if p1[0]>300 and p1[1]>0 and p1[0]<350 and p1[1]<50:
                        primitiva=13#preenche com rosa
                        continue
                    if p1[0]>350 and p1[1]>0 and p1[0]<400 and p1[1]<50:
                        primitiva=14#preenche com laranja
                        continue
                    if p1[0]>400 and p1[1]>0 and p1[0]<450 and p1[1]<50:
                        primitiva=15#preenche com ciano
                        continue
                    if p1[0]>450 and p1[1]>0 and p1[0]<500 and p1[1]<50:
                        primitiva=16#preenche com amarelo escuro
                        continue
                    if p1[0]>500 and p1[1]>0 and p1[0]<550 and p1[1]<50:
                        primitiva=17#preenche com marrom escuro
                        continue
                    if p1[0]>550 and p1[1]>0 and p1[0]<600 and p1[1]<50:
                        primitiva=18#preenche com roxo
                        continue
                    if p1[0]>600 and p1[1]>0 and p1[0]<650 and p1[1]<50:
                        primitiva=19#preenche com verde agua
                        continue
                    if p1[0]>650 and p1[1]>0 and p1[0]<700 and p1[1]<50:
                        primitiva=20#preenche com cor de pele
                        continue
                    if p1[0]>700 and p1[1]>0 and p1[0]<750 and p1[1]<50:
                        primitiva=21#preenche com azul esverdeado
                        continue
                    if p1[0]>750 and p1[1]>0 and p1[0]<800 and p1[1]<50:
                        primitiva=22#preenche com marrom roseado
                        continue
                    if p1[0]>0 and p1[1]>300 and p1[0]<50 and p1[1]<600:
                        primitiva=23#apaga a area de desenho
                        window.fill(background)
                        # Cor 0
                        quadrado(window, 0, 50, 50, 50, black)
                        flood_Fill(window, 10, 1, black)  # preenche com preto
                        # Cor 1
                        quadrado(window, 50, 100, 50, 50, black)
                        flood_Fill(window, 60, 1, (169, 169, 169))  # preenche com cinza
                        # Cor 2
                        quadrado(window, 100, 150, 50, 50, black)
                        flood_Fill(window, 110, 1, (0, 0, 255))  # preenche com azul
                        # Cor 3
                        quadrado(window, 150, 200, 50, 50, black)
                        flood_Fill(window, 160, 1, (255, 255, 0))  # preenche com amarelo
                        # Cor 4
                        quadrado(window, 200, 250, 50, 50, black)
                        flood_Fill(window, 210, 1, red)  # preenche com vermelho
                        # Cor 5
                        quadrado(window, 250, 300, 50, 50, black)
                        flood_Fill(window, 260, 1, (0, 255, 0))  # preenche com verde
                        # Cor 6
                        quadrado(window, 300, 350, 50, 50, black)
                        flood_Fill(window, 310, 1, (255, 105, 180))  # preenche com rosa
                        # Cor 7
                        quadrado(window, 350, 400, 50, 50, black)
                        flood_Fill(window, 360, 1, (255, 140, 0))  # preenche com laranja
                        # Cor 8
                        quadrado(window, 400, 450, 50, 50, black)
                        flood_Fill(window, 410, 1, (0, 191, 255))  # preenche com ciano
                        # Cor 9
                        quadrado(window, 450, 500, 50, 50, black)
                        flood_Fill(window, 460, 1, (255, 191, 0))  # preenche com amarelo escuro
                        # Cor 10
                        quadrado(window, 500, 550, 50, 50, black)
                        flood_Fill(window, 510, 1, (128, 0, 0))  # preenche com marrom escuro
                        # Cor 11
                        quadrado(window, 550, 600, 50, 50, black)
                        flood_Fill(window, 560, 1, (138, 0, 138))  # preenche com roxo
                        # Cor 12
                        quadrado(window, 600, 650, 50, 50, black)  # preenche com verde agua
                        flood_Fill(window, 610, 1, (80, 200, 120))
                        # Cor 13
                        quadrado(window, 650, 700, 50, 50, black)  # preenche com rosa cor de pele
                        flood_Fill(window, 660, 1, (190, 91, 89))
                        # Cor 14
                        quadrado(window, 700, 750, 50, 50, black)  # preenche com azul esverdeado
                        flood_Fill(window, 710, 1, (0, 139, 139))
                        # Cor 15
                        quadrado(window, 750, 800, 50, 50, black)  # preenche com marrom rosa
                        pygame.draw.rect(window, (166, 70, 62), (751, 0, 49, 50))

                        # interface:

                        bresenham2(window, 50, 50, 800, 50, black)
                        bresenham2(window, 50, 50, 50, 600, black)
                        # Moldura da janela
                        bresenham2(window, 0, 0, 0, 600, black)
                        bresenham2(window, 0, 0, 800, 0, black)
                        bresenham2(window, 800, 0, 800, 600, black)
                        bresenham2(window, 0, 600, 800, 600, black)

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
                        circulo(window, 24, 325, 40, 325, black)
                        # polilinha
                        quadrado(window, 50, 50, 300, 350, black)
                        bresenham2(window, 10, 260, 20, 280, black)
                        bresenham2(window, 20, 280, 30, 260, black)
                        bresenham2(window, 30, 260, 40, 280, black)
                        # spline ou bezier
                        quadrado(window, 50, 50, 250, 300, black)
                        bezier(window, (10, 210), (20, 240), (45, 240), black)
                        # polilinha
                        quadrado(window, 50, 50, 300, 350, black)
                        bresenham2(window, 10, 260, 20, 280, black)
                        bresenham2(window, 20, 280, 30, 260, black)
                        bresenham2(window, 30, 260, 40, 280, black)
                        primitiva=0
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
                if primitiva==7:#preenche com preto
                        p2=pygame.mouse.get_pos()
                        if p2[0]>50 and p2[1]>50:
                            flood_Fill(window,p2[0],p2[1],black)
                        primitiva=0
                        continue
                if primitiva==8:#preenche com cinza
                        p2=pygame.mouse.get_pos()
                        if p2[0] > 50 and p2[1] > 50:
                            flood_Fill(window,p2[0],p2[1],(169,169,169))
                        primitiva=0
                        continue
                if primitiva==9:#preenche com azul
                        p2=pygame.mouse.get_pos()
                        if p2[0] > 50 and p2[1] > 50:
                            flood_Fill(window,p2[0],p2[1],(0,0,255))
                        primitiva=0
                        continue
                if primitiva==10:#preenche com amarelo
                        p2=pygame.mouse.get_pos()
                        if p2[0] > 50 and p2[1] > 50:
                            flood_Fill(window,p2[0],p2[1],(255,255,0))
                        primitiva=0
                        continue
                if primitiva==11:#preenche com vermelho
                        p2=pygame.mouse.get_pos()
                        if p2[0] > 50 and p2[1] > 50:
                            flood_Fill(window,p2[0],p2[1],red)
                        primitiva=0
                        continue
                if primitiva==12:#preenche com verde
                        p2=pygame.mouse.get_pos()
                        if p2[0] > 50 and p2[1] > 50:
                            flood_Fill(window,p2[0],p2[1],(0,255,0))
                        primitiva=0
                        continue
                if primitiva==13:#preenche com rosa
                        p2=pygame.mouse.get_pos()
                        if p2[0] > 50 and p2[1] > 50:
                            flood_Fill(window,p2[0],p2[1],(255, 105, 180))
                        primitiva=0
                        continue
                if primitiva==14:#preenche com laranja
                        p2=pygame.mouse.get_pos()
                        if p2[0] > 50 and p2[1] > 50:
                            flood_Fill(window,p2[0],p2[1],(255, 140, 0))
                        primitiva=0
                        continue
                if primitiva==15:#preenche com ciano
                        p2=pygame.mouse.get_pos()
                        if p2[0] > 50 and p2[1] > 50:
                            flood_Fill(window,p2[0],p2[1],(0, 191, 255))
                        primitiva=0
                        continue
                if primitiva==16:#preenche com amarelo escuro
                        p2=pygame.mouse.get_pos()
                        if p2[0] > 50 and p2[1] > 50:
                            flood_Fill(window,p2[0],p2[1],(255, 191, 0))
                        primitiva=0
                        continue
                if primitiva==17:#preenche com amarelo escuro
                        p2=pygame.mouse.get_pos()
                        if p2[0] > 50 and p2[1] > 50:
                            flood_Fill(window,p2[0],p2[1],(128, 0, 0))
                        primitiva=0
                        continue
                if primitiva==18:#preenche com roxo
                        p2=pygame.mouse.get_pos()
                        if p2[0] > 50 and p2[1] > 50:
                            flood_Fill(window,p2[0],p2[1],(138, 0, 138))
                        primitiva=0
                        continue
                if primitiva==19:#preenche com verde agua
                        p2=pygame.mouse.get_pos()
                        if p2[0] > 50 and p2[1] > 50:
                            flood_Fill(window,p2[0],p2[1],(80, 200, 120))
                        primitiva=0
                        continue
                if primitiva==20:#preenche com cor de pele
                        p2=pygame.mouse.get_pos()
                        if p2[0] > 50 and p2[1] > 50:
                            flood_Fill(window,p2[0],p2[1],(190, 91, 89))
                        primitiva=0
                        continue
                if primitiva==21:#preenche com azul esverdeado
                        p2=pygame.mouse.get_pos()
                        if p2[0] > 50 and p2[1] > 50:
                            flood_Fill(window,p2[0],p2[1],(0, 139, 139))
                        primitiva=0
                        continue
                if primitiva==22:#preenche com marrom rosa escuro
                        p2=pygame.mouse.get_pos()
                        if p2[0] > 50 and p2[1] > 50:
                            flood_Fill(window,p2[0],p2[1],(166, 70, 62))
                        primitiva=0
                        continue
    pygame.display.update()