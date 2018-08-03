#include <stdio.h>
#include <stdlib.h>

typedef struct no* pilha;

pilha cria_pilha();

int pilha_vazia(pilha p);

int empilha(pilha *p, int x);

int desempilha(pilha *p, int *x);

int le_topo(pilha *p, int *x);

int print_pilha(pilha *p);

int conversor(pilha *p, int x);