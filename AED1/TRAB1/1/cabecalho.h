#include <stdio.h>
#include <stdlib.h>
#define MAX 10

typedef struct lista Lista;
Lista * cria_lista();
int lista_vazia(Lista *l);
int lista_cheia(Lista *l);
int insere_elem(Lista *l, int elem);
int remove_elem(Lista *l, int elem);
void imprimi_lista(Lista *l);
int remove_todos(Lista *l,int elem);
int inserir_inicio(Lista *l, int elem);
int remove_impares(Lista *l);
int menor(Lista *l);
int tamanho(Lista *l);
Lista * concatenar(Lista *A, Lista *B);