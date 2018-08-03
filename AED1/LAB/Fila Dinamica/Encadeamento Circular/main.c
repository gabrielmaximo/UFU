#include "fila.h"

int main(){

    int x;
    Fila f = cria_fila();
    print_fila(&f);
    insere_final(&f, -4);
    insere_final(&f, 13);
    insere_final(&f, 42);
    insere_final(&f, 0);
    insere_final(&f, -2);
    insere_final(&f, 12);
    insere_final(&f, -1);
    insere_final(&f, 24);
    insere_final(&f, 3);
    print_fila(&f);
    ret_prim(&f, &x);
    printf("o elemento removido foi %d\n", x);
    ret_prim(&f, &x);
    printf("o elemento removido foi %d\n", x);
    ret_prim(&f, &x);
    printf("o elemento removido foi %d\n", x);
    ret_prim(&f, &x);
    printf("o elemento removido foi %d\n", x);
    print_fila(&f);

    return 0;
}