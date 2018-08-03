#include <stdio.h>
#include <stdlib.h>

typedef struct no Lista;
	Lista *cria_lista();
	int lista_vazia(Lista *l);
	int insere_elem(Lista *l,int elem);
	int remove_elem(Lista *l,int elem);
	int remove_todos(Lista *l,int elem);
	int remove_maior(Lista *l);
	Lista * multiplo_3(Lista *l);
	void imprimi_lista(Lista *l);
	int tamanho(Lista *l);