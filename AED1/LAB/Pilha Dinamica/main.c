#include "pilha.h"

int main() {
    int x = 42;
    pilha p = cria_pilha();
    conversor(&p,x);
    print_pilha(&p);

    return 0;
}