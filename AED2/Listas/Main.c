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
    printf("\nA altura eh: %d\nA qtd de nos eh: %d\nA qtd de folhas eh: %d\n", h, nos, folhas);
    maior = maiorElem(*raiz);
    menor = menorElem(*raiz);
    printf("O maior elem da arvore eh: %d\nO menor elem da arvore eh: %d\n", maior, menor);
    if(consultaValor(*raiz, 46)) printf("\nO valor esta na Arvore\n");
    else printf("O Valor nao esta na ARVORE!\n");
    exibirPares(*raiz);
    pares = contarNosPares(*raiz);
    printf("\nO numero de Pares da arvore eh: %d\n", pares);
    impares = nos - pares;
    printf("A qtd de nos impares eh: %d\n", impares);
}