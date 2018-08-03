#include "cabecalho.h"

struct no{
	int elemento;
	struct no *prox;
	struct no *ant;
};
Lista *cria_lista(){
	Lista *L = (Lista *) malloc(sizeof(Lista));
	if(L){
		L->ant=NULL;
		L->elemento=0;
	}
	return L;
}
int lista_vazia(Lista *l){
	if(l->prox==NULL && l->ant==NULL) return 1;
	return 0;
}
int insere_elem(Lista *l,int elem){
	if(l==NULL) return 0;
	Lista *temp = l;
	Lista *no = cria_lista();
	if(no){
		no->elemento = elem;
		no->prox = temp->prox;
		no->ant = temp;
		temp->prox = no;
		return 1;
	}
	return 0;
}
int remove_elem(Lista *l,int elem){
	if(l==NULL) return 0;
	if(lista_vazia(l)) return 0;
	Lista *temp = l;
	Lista *temp_aux;
	while(temp->prox!=NULL&&temp->prox->elemento!=elem){
		temp = temp->prox;
	}
	if(temp->prox==NULL) return 0; //chegou ao fim da lista
	temp_aux = temp->prox;
	temp->prox = temp_aux->prox;
	if(temp_aux->prox!=NULL){//remoçao do ultimo elemento
		Lista *aux = temp_aux->prox;
		aux->ant = temp_aux->ant;
	}
	free(temp_aux);
	return 1;
}
int remove_todos(Lista *l,int elem){
	if(l==NULL) return 0;
	if(lista_vazia(l)) return 0;
	int removido = 0;
	Lista *temp = l;
	Lista *temp_aux;
	while(temp->prox!=NULL){
		if(temp->prox->elemento==elem){
			temp_aux = temp->prox;
			temp->prox = temp_aux->prox;
			if(temp_aux->prox!=NULL){//remoçao do ultimo elemento
				Lista *aux = temp_aux->prox;
				aux->ant = temp_aux->ant;
			}
			free(temp_aux);
			removido++;
		}
		temp = temp->prox;
	}
	if(removido)return 1;
	return 0;
}
int remove_maior(Lista *l){
	if(l==NULL || lista_vazia(l)) return 0;
	int maior = l->prox->elemento;
	Lista *temp = l;
	while(temp->prox!=NULL){
		if(temp->prox->elemento > maior) maior=temp->prox->elemento;
		temp = temp->prox;
	}
	remove_elem(l,maior);
}
Lista * multiplo_3(Lista *l){
	Lista *C = cria_lista();
	if(C){
		Lista *temp = l;
		while(temp->prox!=NULL){
			if(temp->prox->elemento%3==0){
				insere_elem(C,temp->prox->elemento);
			}
			temp = temp->prox;
		}
	}
	return C;
}
void imprimi_lista(Lista *l){
	if(l==NULL) return;
	if(lista_vazia(l)) {
		printf("Lista = {}\n");
		return;
	}
	Lista *temp = l;
	printf("Lista = {");
	while(temp->prox!=NULL){
		printf("%d ",temp->prox->elemento);
		temp = temp->prox;
	}
	printf("\b}\n");
}
int tamanho(Lista *l){
	if(l==NULL||lista_vazia(l)) return 0;
	Lista *temp = l;
	int tam = 0;
	while(temp->prox!=NULL){
		tam++;
		temp = temp->prox;
	}
	return tam;
}