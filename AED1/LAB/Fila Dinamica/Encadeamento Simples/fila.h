#include <stdio.h>
#include <stdlib.h>

typedef struct no * No;
typedef struct fila *Fila;

Fila cria_fila();

int fila_vazia(Fila f);

int insere_final(Fila *p, int x);

int print_fila(Fila *p);

int ret_prim(Fila *p, int *x);

