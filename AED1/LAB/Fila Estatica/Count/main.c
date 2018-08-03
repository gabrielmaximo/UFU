#include "fila.h"

int main() {

    Fila p = cria_fila();
    int x;
    insere_fim(p,42);
    insere_fim(p,19);
    insere_fim(p,13);
    insere_fim(p,7);
    insere_fim(p,5);
    insere_fim(p,-1);
    insere_fim(p,31);
    insere_fim(p,-7);
    insere_fim(p,0);
    insere_fim(p,6);
    print_fila(p);
    remove_ini(p, &x);
    printf("removido = %d\n", x);
    print_fila(p);
    remove_ini(p, &x);
    printf("removido = %d\n", x);
    print_fila(p);
    remove_ini(p, &x);
    printf("removido = %d\n", x);
    print_fila(p);

    return 0;
}