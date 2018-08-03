#ifndef CABECALHO_H_INCLUDE
#define CABECALHO_H_INCLUDE
#include <stdio.h>
#include <stdlib.h>

typedef struct no *list;
list cria_lista();
int lista_vazia(list l);
int insere_inicio(list *l, int elem);
int insere_final(list *l, int elem);
int remove_elem(list *l, int elem);
int remove_todos(list *l, int elem);
int remove_pares(list *l);
int print_lista(list l);
int maior(list l);
int tamanho(list l);
int concatenar(list l, list l2);
#endif
