#include <stdio.h>
#include <stdlib.h>

struct No{
    struct No *prox, *ant;
    int info;
};

struct Deck{
    struct No *ini,*fim;
};

typedef struct Deck* deck;
typedef struct No* no;

deck cria_deck(){
    deck D = (deck) malloc(sizeof(struct Deck));
    if(D != NULL){
        D->ini = NULL;
        D->fim = NULL;
    }
    return D;
}

int deck_vazio(deck D){
    if(D->ini == NULL) return 1;
    return 0;
}

int insere_acima(deck *D, int x){
    no N = (no) malloc(sizeof(struct No));
    if(N == NULL) return 0;
    N->info = x;
    if(deck_vazio(*D)){
        N->prox = NULL;
        N->ant = NULL;
        (*D)->fim = N;
    }
    else{
        N->prox = (*D)->ini;
        N->ant = NULL;
    }
        (*D)->ini = N;
    return  1;
}

int insere_abaixo(deck *D, int x){
    no N = (no) malloc(sizeof(struct No));
    if(N == NULL) return 0;
    N->info = x;
    if(deck_vazio(*D)){
        N->prox = NULL;
        N->ant = NULL;
        (*D)->ini = N;
    }
    else{
        N->prox = NULL;
        (*D)->fim->prox = N;
        N->ant = (*D)->fim;
    }
    (*D)->fim = N;
    return 1;
}

int remove_topo(deck *D, int *x){
    if(deck_vazio(*D)) return 0;
    if((*D)->ini == (*D)->fim){
        *x = (*D)->ini->info;
        (*D)->ini = NULL;
        (*D)->fim = NULL;
        return 1;
    }
    *x = (*D)->ini->info;
    (*D)->ini = (*D)->ini->prox;
    (*D)->ini->ant = NULL;
    return 1;
}

int remove_fim(deck *D, int *x){
    if(deck_vazio(*D)) return 0;
    if((*D)->ini == (*D)->fim){
        *x = (*D)->fim->info;
        (*D)->ini = NULL;
        (*D)->fim = NULL;
        return 1;
    }
    *x = (*D)->fim->info;
    (*D)->fim = (*D)->fim->ant;
    (*D)->fim->prox = NULL;
    return 1;
}

int print_deck(deck D){
    if(deck_vazio(D)){
        printf("NULL\n");
        return 0;
    }    
    no aux = D->ini;
    while(aux != NULL){
        printf("%d -> ", aux->info);
        aux = aux->prox;
    }
    printf("NULL\n");
    return 1;
}
