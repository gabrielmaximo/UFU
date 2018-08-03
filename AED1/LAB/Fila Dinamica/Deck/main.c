#include "deck.h"

int main() {

    deck D = cria_deck();
    insere_acima(&D, 4);
    insere_acima(&D, 0);
    insere_acima(&D, -1);
    insere_acima(&D, 2);
    insere_acima(&D, 5);
    print_deck(D);

    return 0;
}