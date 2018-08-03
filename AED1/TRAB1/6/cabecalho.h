#include <stdio.h>
#include <stdlib.h>
    
    typedef struct no Lista;
	Lista *cria_lista();
	int lista_vazia(Lista **L);
	int insere_inicio(Lista **l, int elem);
	int insere_elem(Lista *l, int elem);
	int insere_posicao(Lista *l, int elem, int posicao);
	int remove_elem(Lista **l, int elem);
	int remove_posicao(Lista **l, int posicao);
	int maior(Lista *l);
	void imprimi_lista(Lista *l);
	int tamanho(Lista *l);