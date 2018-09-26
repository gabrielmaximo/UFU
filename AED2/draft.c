#include <stdio.h>

int main(){

    int i, V[100] = {}, N = 8, x;

    for (i = 0; i < N; i++){
        scanf("%d", &x);
        if(x > 99){
            printf("Entrada Inválida!\nDigite apenas numeros menores que 100 e maiores que 0\n");
            return 0;
        }
        V[x] = x;
    }
    for(i = 0; i < 100; i++) {
        if(V[i] != 0)
            printf("[%d] ", V[i]);
    }
    printf("\n");
    return 0;
}