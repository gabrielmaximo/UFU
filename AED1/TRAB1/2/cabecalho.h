#include <stdio.h>
#include <stdlib.h>
#define MAX 100

typedef struct lista Lista;
Lista * cria_lista();
int lista_vazia(Lista *l);
int lista_cheia(Lista *l);
int insere_ord(Lista *l, int elem);
int remove_ord(Lista *l, int elem);
void imprimi_lista(Lista *l);
int remove_todos(Lista *l,int elem);
int inserir_inicio(Lista *l, int elem);
int remove_pares(Lista *l);
int maior(Lista *l);
int tamanho(Lista *l);
int iguais(Lista *A, Lista *B);
Lista * concatenar(Lista *A, Lista *B);