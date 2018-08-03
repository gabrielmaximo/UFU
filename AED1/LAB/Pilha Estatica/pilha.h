#include <stdio.h>
#include <stdlib.h>

typedef struct pilha* push;

push cria_pilha();

int pilha_vazia(push p);

int pilha_cheia(push p);

int empilha(push p, int x);

int desempilha(push p, int *x);

int le_topo(push p, int *x);

int print_pilha(push p);

int conversor(push *p, unsigned long long int x);