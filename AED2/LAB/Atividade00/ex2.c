#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(){
    FILE *p;
    p = fopen("notas.txt", "r");
    if(p == NULL){
        printf("Erro na abertura do arquivo!\n");
        exit(1);
    }

    int count = 0;
    float maior = 0, nota, media = 0;
    char nome[15], nome_maior[15];

    while(1){
        fscanf(p,"%*s %s %*s %f", nome, &nota);
        if(feof(p))
            break;
        if(maior < nota){
            maior = nota;
            strcpy(nome_maior, nome);
        }
        count++;
        media += nota;
    }

    printf("maior nota = %s: %.2f\nmedia = %.2f\nqtd de alunos = %d\n", nome_maior, maior, media/count, count);
    fclose(p);
    return 0;
}