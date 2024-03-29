#include "cabecalho.h"

struct no{
	int elemento;
	struct no *prox;	
};
Lista *cria_lista(){
	Lista *C = (Lista *) malloc(sizeof(Lista));
	if(C){
		C->prox = C;
		C->elemento = 0;
	}
	return C;
}
int lista_vazia(Lista **L){
	Lista *temp = *L;
	if(temp->prox == temp) return 1;
	return 0;
}
int insere_inicio(Lista **l, int elem){
	Lista *temp = *l;
	Lista *no = (Lista *) malloc(sizeof(Lista));
	if(no==NULL) return 0;
	no->elemento = elem;
	no->prox = temp->prox;
	temp->prox = no;
	return 1;
}
int insere_elem(Lista *l, int elem){
	Lista *no = (Lista *) malloc(sizeof(Lista));
	if(no==NULL) return 0;
	no->elemento = elem;
	
	if(lista_vazia(&l)){
		no->prox = l;
		l->prox = no;
		return 1;
	}

	Lista *aux = l;
	Lista *temp = l;
	while(aux->prox!=temp){
		aux = aux->prox;
	}
	no->prox = aux->prox;
	aux->prox = no;
	return 1;
}
int insere_posicao(Lista *l, int elem,int posicao){
	Lista *no = (Lista *) malloc(sizeof(Lista));
	if(no==NULL) return 0;
	no->elemento = elem;

	int contador=0;
	
	if(lista_vazia(&l)){
		no->prox = l;
		l->prox = no;
		return 1;
	}

	Lista *aux = l;
	Lista *temp = l;
	while(aux->prox!=temp&&contador < posicao){
		aux = aux->prox;
		contador++;
	}
	no->prox = aux->prox;
	aux->prox = no;
	return 1;
}
int remove_elem(Lista **l, int elem){
	if(lista_vazia(l)) return 0;
	Lista *temp = *l;
	Lista *temp_aux = *l;
	while(temp_aux->prox!=temp&&temp_aux->prox->elemento!=elem){
		temp_aux = temp_aux->prox;
	}
	if(temp_aux->prox==temp) return 0;
	Lista *aux = temp_aux->prox;
	temp_aux->prox = aux->prox;
	free(aux);
	return 1;
}
int remove_posicao(Lista **l, int posicao){
	if(lista_vazia(l)) return 0;
	Lista *temp = *l;
	Lista *temp_aux = *l;
	int contador=0;
	while(temp_aux->prox!=temp&&contador<posicao){
		temp_aux = temp_aux->prox;
		contador++;
	}
	if(temp_aux->prox==temp) return 0;
	Lista *aux = temp_aux->prox;
	temp_aux->prox = aux->prox;
	free(aux);
	return 1;
}
int maior(Lista *l){
	if(lista_vazia(&l)) return 0;
	int m = l->prox->elemento;
	Lista *temp = l;
	Lista *temp_aux = l;
	while(temp_aux->prox!=temp){
		if(temp_aux->prox->elemento>m)m=temp_aux->prox->elemento;
		temp_aux = temp_aux->prox;
	}
	return m+1;//pode existir o elemento 0 na lista
}
void imprimi_lista(Lista *l){
	if(lista_vazia(&l)) {
		printf("Lista = {}\n");
		return;
	}
	Lista *temp_aux = l;
	Lista *temp = l;
	printf("Lista = {");
	while(temp_aux->prox!=temp){
		printf("%d ",temp_aux->prox->elemento);
		temp_aux = temp_aux->prox;
	}
	printf("\b}\n");
}
int tamanho(Lista *l){
	int tam=0;
	if(lista_vazia(&l)) return 0;
	Lista *temp = l;
	Lista *temp_aux = l;
	while(temp_aux->prox!=temp){
		temp_aux = temp_aux->prox;
		tam++;
	}
	return tam;
}