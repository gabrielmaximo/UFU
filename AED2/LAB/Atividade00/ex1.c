#include <stdio.h>
#include <stdlib.h>

int main(){
    FILE *p;
    p = fopen("compra.txt", "r");
    if(p == NULL){
        printf("Erro na abertura do arquivo!\n");
        exit(1);
    }

    int qtd = 0;
    float val = 0, total = 0;
    char nome[15];

    while(1){
        fscanf(p,"%*s %d %f", &qtd, &val);
        if(feof(p))
            break;
        total += (qtd * val);
    }

    printf("total = %.2f\n", total);


    fclose(p);
    return 0;

}