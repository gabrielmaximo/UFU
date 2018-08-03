#include "cabecalho.h"

struct no{
    int info;
    struct no *prox;
};

list cria_lista(){
	list cab;
    cab = (list) malloc(sizeof(struct no));
    if(cab != NULL){
        cab->prox = NULL;
        cab->info = 0;
    }
    return cab;
}

int lista_vazia(list l){
    if(l->prox == NULL) return 1;
    return 0;
}

int insere_ord(list *l, int elem){
    list N = (list) malloc(sizeof(struct no));
    if(N == NULL) return 0;
    N->info = elem;
    list aux = *l;
    while(aux->prox != NULL && aux->prox->info < elem) aux = aux->prox;
    N->prox = aux->prox;
    aux->prox = N;
    (*l)->info++;
    return 1;
}

int remove_ord(list *l, int elem){
    if(*l == NULL) return 0;
    list aux = *l;

    while(aux->prox != NULL && aux->prox->info < elem) aux = aux->prox;
    if (aux->prox == NULL || aux->prox->info > elem) return 0;
    list aux2 = aux->prox;
    aux->prox = aux2->prox;
    free(aux2);
    (*l)->info--;
    return 1;
}

int print_lista(list l){
	if(l->prox == NULL) {
		printf("{Lista Vazia}\n");
		return 0;
	}
	list aux = l;
	printf("{");
	while(aux->prox != NULL){
		printf("%d ", aux->prox->info);
		aux = aux->prox;
	}
	printf("\b}\n");
	return 1;
}

int remove_impares(list *l){
    if(*l == NULL) return 0;
   	list aux = *l;
	while(aux->prox != NULL && aux->prox->info%2 != 0){
        list aux2 = aux->prox;
        aux->prox = aux2->prox;
        free(aux2);
    }
    *l = aux;
    if(aux->prox == NULL) return 1;
    list ant = aux;
    aux = aux->prox;
    while(aux != NULL){
        if(aux->info%2 != 0){
            ant->prox = aux->prox;
            free(aux);
            aux = ant;
        }
        ant = aux;
        aux = aux->prox;
    }
    return 1;
}

int menor(list l){
    if(l == NULL) return 0;
    int menor = 9999999;
    list aux = l;
    while(aux->prox != NULL){
        if(aux->prox->info < menor) menor = aux->prox->info;
        aux = aux->prox;
    }
    return menor;
}

list tamanho(list l){
    if(l == NULL) return 0;
    return l->info;
}

list intercala(list l, list l2){
    if(l == NULL && l2 == NULL) return 0;
    list aux = l, l3 = cria_lista(), aux2 = l2;
    while(aux->prox != NULL){ 
        insere_ord(&l3, aux->prox->info);
        aux = aux->prox;
    }
    while(aux2->prox != NULL){ 
        insere_ord(&l3, aux2->prox->info);
        aux2 = aux2->prox;
    }
    return l3;
}

int iguais(list l, list l2){
    if(tamanho(l) != tamanho(l2)) return 0;
    list aux = l->prox, aux2 = l2->prox;
    while(aux->prox != NULL){
        if(aux->prox->info != aux2->prox->info) return 0;
        aux = aux->prox;
        aux2 = aux2->prox;
    }
    return 1;
}

