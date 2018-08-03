#include <stdio.h>
#include <stdlib.h>

typedef struct fila* Fila;
typedef struct no* No;

struct no{
    struct no *prox;
    int elem;
};

struct fila{
    struct no *ini;
    struct no *fim;
};

Fila cria_fila(){
    Fila f = (Fila) malloc(sizeof(struct fila));
    if (f != NULL) {
        f->ini = NULL;
        f->fim = NULL;
    }
    return f;
}

int fila_vazia(Fila f){
   if(f->ini == NULL) return 1;
   return 0;
}

int insere_ord(Fila *f, int x) {
    struct no * N = (struct no *) malloc(sizeof(struct no));
    if (N == NULL) return 0;
    N->elem = x;  
    if(fila_vazia(*f)){
        N->prox = NULL;
        (*f)->ini = N;
        (*f)->fim = N;
        return 1;
    }
    if((*f)->ini->elem >= x){
        N->prox = (*f)->ini;
        (*f)->ini = N;
        return 1;
    }
    if((*f)->fim->elem <= x){
        N->prox = NULL;
        (*f)->fim->prox = N;
        (*f)->fim = N;
        return 1;
    }
    No aux = (*f)->ini;
    while(aux->prox->elem < x && aux->prox != NULL) aux = aux->prox;
    N->prox = aux->prox;
    aux->prox = N;
    return 1;
}

int ret_prim(Fila *f, int *x){
    if(fila_vazia(*f)) return 0;
    No aux = (*f)->ini;
    *x = aux->elem;
    if((*f)->ini == (*f)->fim)
        (*f)->fim = NULL;
    (*f)->ini = aux->prox;
    free(aux);
    return 1;
}

int print_fila(Fila *f){
    if(fila_vazia(*f)){
        printf("NULL\n");
        return 0;
    }    
    No aux = (*f)->ini;
    while(aux != NULL){
        printf("%d->", aux->elem);
        aux = aux->prox;
    }
    printf("NULL\n");
    return 1;
}