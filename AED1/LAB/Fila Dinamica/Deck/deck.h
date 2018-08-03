#include <stdio.h>
#include <stdlib.h>

typedef struct Deck* deck;
typedef struct No* no;

deck cria_deck();

int deck_vazio(deck D);

int insere_acima(deck *D, int x);

int insere_abaixo(deck *D, int x);

int remove_topo(deck *D, int *x);

int remove_fim(deck *D, int *x);

int print_deck(deck D);