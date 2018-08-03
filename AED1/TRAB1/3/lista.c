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

int insere_inicio(list *l, int elem){
	list N = (list) malloc(sizeof(struct no));
	if (N == NULL) return 0;
	N->info = elem;
	N->prox = *l;
	*l = N;
	return 1;
}

int insere_final(list *l, int elem){
	list N = (list) malloc(sizeof(struct no));
	if(N == NULL) return 0;
	N->info = elem;
	N->prox = NULL;
	if(*l == NULL) *l = N;
	else{
		list aux = *l;
		while(aux->prox != NULL){
			aux = aux->prox;
		}
		aux->prox = N;
	}
	return 1;
}

int remove_elem(list *l, int elem){
	if(*l == NULL) return 0;
	list aux = *l;
	if(elem == (*l)->info){
		*l = aux->prox;
		free(aux);
		return 1;
	}
	while(aux->prox != NULL && aux->prox->info != elem)
		aux = aux->prox;

	if(aux->prox == NULL) return 0;
	list aux2 = aux->prox;
	aux->prox = aux2->prox;
	free(aux2);
	return 1;
}

int remove_todos(list *l, int elem){
	if(*l == NULL) return 0;
	while(remove_elem(l, elem));
	return 1;
}

int remove_pares(list *l){
	if(*l == NULL) return 0;
   	list aux = *l;
	while(aux != NULL && aux->info%2 == 0){
        list aux2 = aux;
        aux = aux2->prox;
        free(aux2);
    }
    *l = aux;
    if(aux == NULL) return 1;
    list ant = aux;
    aux = aux->prox;
    while(aux != NULL){
        if(aux->info%2 == 0){
            ant->prox = aux->prox;
            free(aux);
            aux = ant;
        }
        ant = aux;
        aux = aux->prox;
    }
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

int maior(list l){
    if(l == NULL) return 0;
    int maior = -9999999;
    list aux = l;
    while(aux != NULL){
        if(aux->info > maior) maior = aux->info;
        aux = aux->prox;
    }
    return maior;
}

int concatenar(list l, list l2){
    if(l == NULL && l2 == NULL) return 0;
    list aux = l;
    while(aux->prox != NULL) aux = aux->prox;
    aux->prox = l2;

    return 1;
}