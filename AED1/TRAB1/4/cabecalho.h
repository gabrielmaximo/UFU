#include <stdio.h>
#include <stdlib.h>

typedef struct no *list;
list cria_lista();
int lista_vazia(list l);
int insere_ord(list *l, int elem);
int remove_ord(list *l, int elem);
int remove_impares(list *l);
int print_lista(list l);
int menor(list l);
int tamanho(list l);
list intercala(list l, list l2);