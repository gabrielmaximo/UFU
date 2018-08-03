#include "pilha.h"

int main() {
    unsigned long long int x = 18446744073709551615LLU; // numero de 53 bits.
    push p = cria_pilha();
    int count;
    count = conversor(&p,x);
    print_pilha(p);
    printf("bits = [%d]\n", count);
    return 0;
}
 