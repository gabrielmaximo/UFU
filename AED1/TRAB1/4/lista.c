#include "cabecalho.h"

struct no{
    int info;
    struct no *prox;
};

list cria_lista(){
	return NULL;
}

int lista_vazia(list l){
	if(l == NULL) return 1;

	return 0;
}

int insere_ord(list *l, int elem){
    list N = (list) malloc(sizeof(struct no));
    if(N == NULL) return 0;
    N->info = elem;
    if(*l == NULL || elem <= (*l)->info){
        N->prox = *l;
        *l = N;
        return 1;
    }
    list aux = *l;
    while(aux->prox != NULL && aux->prox->info < elem) // 3 4 5 8 12 13 --> 9
        aux = aux->prox;
    if(elem == 9) printf("aux->prox->info = %d\n", aux->prox->info);
    N->prox = aux->prox;
    aux->prox = N;
    return 1;
}

int print_lista(list l){
	if(l == NULL) {
		printf("{Lista Vazia}\n");
		return 0;
	}
	list aux = l;
	printf("{");
	while(aux != NULL){
		printf("%d ", aux->info);
		aux = aux->prox;
	}
	printf("\b}\n");
	return 1;
}

int remove_ord(list *l, int elem){
	if(*l == NULL) return 0;
	list aux = *l;
	if(elem == (*l)->info){
		*l = aux->prox;
		free(aux);
		return 1;
	}
	while(aux->prox != NULL && aux->prox->info != elem){
        if(aux->prox->info > elem) return 0;
		aux = aux->prox;
    }

	if(aux->prox == NULL) return 0;
	list aux2 = aux->prox;
	aux->prox = aux2->prox;
	free(aux2);
	return 1;
}

int remove_impares(list *l){
    if(*l == NULL) return 0;
   	list aux = *l;
	while(aux != NULL && aux->info%2 != 0){
        list aux2 = aux;
        aux = aux2->prox;
        free(aux2);
    }
    *l = aux;
    if(aux == NULL) return 1;
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
    while(aux != NULL){
        if(aux->info < menor) menor = aux->info;
        aux = aux->prox;
    }
    return menor;
}

int tamanho(list l){
    int count = 0;
    list aux = l;
    if(l == NULL) return 0;
    while(aux != NULL) {
        aux = aux->prox;
        count++;
    }
    return count;
}

list intercala(list l, list l2){
    if(l == NULL && l2 == NULL) return 0;
    list aux = l, l3 = cria_lista(), aux2 = l2;
    while(aux != NULL){ 
        insere_ord(&l3, aux->info);
        aux = aux->prox;
    }
    while(aux2 != NULL){ 
        insere_ord(&l3, aux2->info);
        aux2 = aux2->prox;
    }

    return l3;
}
