#include <stdio.h>
#include <stdlib.h>

typedef struct no* pilha;

struct no {
    struct no *prox;
    int info;
};

pilha cria_pilha() {
    return NULL;
}

int pilha_vazia(pilha p) {
    if(p == NULL) return 1;
    return 0;
}

int empilha(pilha *p, int x) {
    pilha N = (pilha) malloc(sizeof(struct no));
    if(N == NULL) return 0;
    N->info = x;
    N->prox = *p;
    *p = N;
    return 1;
}

int desempilha(pilha *p, int *x) {
    if(pilha_vazia(*p)) return 0;
    pilha aux = *p;
    *x = aux->info;
    *p = aux->prox;
    free(aux);
    return 1;
}

int le_topo(pilha *p, int *x) {
    if(pilha_vazia(*p)) return 0;
    *x = (*p)->info;
    return 1;
}

int print_pilha(pilha *p) {
    if(pilha_vazia(*p)) {
        printf( "NULL\n");
        return 0;
    }
    pilha aux = *p;
    printf( "[");
    while(aux != NULL) {
        printf( "%d ", aux->info);
        aux = aux->prox;
    }
    printf( "\b]\n");
}

int par_impar(pilha *p, pilha *p2, pilha *p3){
    if(pilha_vazia(*p)) return 0;
    int x;
    while(*p != NULL){
        desempilha(p, &x);
        if(x % 2 == 0) empilha(p2, x);
        else empilha(p3, x);
    }
    free(*p);
    return 1;
}