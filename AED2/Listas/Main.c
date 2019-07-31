// ArvBin.main

#include "ArvBin.c"

int main(){
    int nos, folhas, h, maior, menor, pares, impares;
    
    ArvBB* raiz = criarArvore();
    insercao(raiz, 50);
    insercao(raiz, 40);
    insercao(raiz, 60);
    insercao(raiz, 30);
    insercao(raiz, 35);
    insercao(raiz, 70);
    insercao(raiz, 65);
    insercao(raiz, 20);
    insercao(raiz, 25);
    insercao(raiz, 80);
    insercao(raiz, 75);
    insercao(raiz, 10);
    insercao(raiz, 90);
    insercao(raiz, 34);
    insercao(raiz, 36);
    insercao(raiz, 64);
    insercao(raiz, 66);
    insercao(raiz, 45);
    insercao(raiz, 55);
    insercao(raiz, 46);
    insercao(raiz, 54);

    exibirEmOrdem(*raiz);
    printf("\n");
    exibirPreOrdem(*raiz);
    printf("\n");
    exibirPosOrdem(*raiz);
    printf("\n");
    nos = contarNos(*raiz);
    folhas = contarFolhas(*raiz);
    h = altura(*raiz);
    printf("\nA altura é: %d\nA qtd de nos é: %d\nA qtd de folhas é: %d\n", h, nos, folhas);
    maior = maiorElem(*raiz);
    menor = menorElem(*raiz);
    printf("O maior elem da arvore é: %d\nO menor elem da arvore é: %d\n", maior, menor);
    if(consultaValor(*raiz, 46)) printf("\nO valor está na Arvore\n");
    else printf("O Valor não está na ARVORE!\n");
    exibirPares(*raiz);
    pares = contarNosPares(*raiz);
    printf("\nO numero de Pares da arvore é: %d\n", pares);
    impares = nos - pares;
    printf("A qtd de nós impares é: %d\n", impares);
}