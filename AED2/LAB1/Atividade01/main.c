#include <stdio.h>
#include <stdlib.h>
#include <time.h>

//#include "ListaSequencial.h"
//#include "ListaDinEncad.h"

int main(){
    clock_t inicio, fim;
    unsigned long int tempo;
    inicio = clock();
    FILE *p;
    p = fopen("tempo.txt", "w");
    if(p == NULL){
        printf("erro na abertura do arquivo\n");
        fclose(p);
        exit(1);
    }
    int i, v[99999];
    v[0] = 0, v[1] = 1;
    for(i = 2;i < 99999;i++){
        v[i] = v[i-2] + v[i-1];
    }
    fim = clock();
    tempo = (fim - inicio) * 1000/CLOCKS_PER_SEC;
    printf("tempo: %lu ms\n", tempo);
    fprintf(p,"tempo: %lu ms\n", tempo);
    fclose(p);
    return 0;
}
