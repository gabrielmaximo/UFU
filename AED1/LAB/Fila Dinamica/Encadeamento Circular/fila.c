#include "fila.h"

struct no{
  struct no* prox;
  int info;  
};

Fila cria_fila(){
    return NULL;
}

int fila_vazia(Fila f){
    if(f == NULL) return 1;
    return 0;
}

int insere_final(Fila *f, int x){
    Fila N = (Fila) malloc(sizeof(struct no));
    N->info = x;
    if(fila_vazia(*f)){
        N->prox = N;
        *f = N;
    }
    else{
        N->prox = (*f)->prox;
        (*f)->prox = N;
        (*f) = N;
    }
    return 1;
}

int ret_prim(Fila *f, int *x){
    if(fila_vazia(*f)) return 0;
    Fila aux = (*f)->prox;
    *x = aux->info;
    if((*f) == aux) *f = NULL;
    (*f)->prox = aux->prox;
    free(aux);
    return 1;
}

int print_fila(Fila *f){
    if(fila_vazia(*f)){
        printf("NULL\n");
        return 0;
    }
    Fila aux = (*f)->prox;
    while(aux->prox != (*f)->prox){
        printf("%d -> ", aux->info);
        aux = aux->prox;
    }
    printf("NULL\n");
    return 1;
}