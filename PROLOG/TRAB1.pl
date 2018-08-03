%dados(Nome, Idade, contato, Sexo, Time, Esporte,Cor_Olhos,Cabelo,Altura,Peso).

% BASE DE CONHECIMENTO

homem(maximo).
homem(adiel).
homem(leo).
mulher(ligia).
mulher(maria).
mulher(poliana).

idade(maximo,20).
idade(adiel,18).
idade(leo,19).
idade(ligia,12).
idade(maria,16).
idade(poliana,21).

gosta_de(maximo,calculo1).
gosta_de(adiel,calculo1).
gosta_de(leo,pci).
gosta_de(ligia,python).
gosta_de(maria,pci).
gosta_de(poliana,calculo1).

cor_olhos(maximo,preto).
cor_olhos(adiel,preto).
cor_olhos(leo,verde).
cor_olhos(ligia,azul).
cor_olhos(maria,verde).
cor_olhos(poliana,preto).

cor_pele(maximo,branca).
cor_pele(adiel,pardo).
cor_pele(leo,pardo).
cor_pele(ligia,branca).
cor_pele(maria,pardo).
cor_pele(poliana,branca).

cor_cabelo(maximo,preto).
cor_cabelo(adiel,preto).
cor_cabelo(leo,loiro).
cor_cabelo(ligia,loiro).
cor_cabelo(maria,loiro).
cor_cabelo(poliana,preto).

time(maximo,palmeiras).
time(adiel,saopaulo).
time(leo,flamengo).
time(ligia,uberlandia).
time(maria,corinthians).
time(poliana,palmeiras).

esporte(maximo,futebol).
esporte(adiel,futebol).
esporte(leo,volei).
esporte(ligia,basquete).
esporte(maria,volei).
esporte(poliana,futebol).

contato(maximo,10101010).
contato(adiel,8007770).
contato(leo,9090190).
contato(ligia,99740543).
contato(maria,99854321).
contato(poliana,99185646).

altura(maximo,184).
altura(adiel,175).
altura(leo,170).
altura(ligia,160).
altura(maria,170).
altura(poliana,175).

peso(maximo,80).
peso(adiel,78).
peso(leo,75).
peso(ligia,50).
peso(maria,70).
peso(poliana,73).

% FUNCOES

gosto_comum(X,Y):-
    gosta_de(X,N), gosta_de(Y,N);
    esporte(X,E), esporte(Y,E);
    cor_pele(X,P), cor_pele(Y,P);
    cor_olhos(X,R), cor_olhos(Y,R);
    cor_cabelo(X,C), cor_cabelo(Y,C);
    time(X,T), time(Y,T).

id_aprox(X,Y):-
    X - Y < 4.

peso_aprox(X,Y):-
    X - Y < 15.

altura_aprox(X,Y):-
    X - Y < 15.

casal(X,Y,Cx,Cy):-
    homem(X), mulher(Y),
    idade(X,Idx), idade(Y,Idy),
    id_aprox(Idx, Idy),
    gosto_comum(X,Y),
    peso(X,Pdx), peso(Y,Pdy),
    peso_aprox(Pdx,Pdy),
    contato(X,Cx), contato(Y,Cy),
    altura(X,Adx), altura(Y,Ady),
    altura_aprox(Adx,Ady).
