#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(){
    char a;
    FILE *f;
    f = fopen("arq.txt", "w");
    if(f == NULL) {
        printf("Erro na abertura do arquivo!\n");
        exit(1);
    }
    while(1){
        printf("entre com dados para serem gravados no arquivo:\n");
        scanf("%c",&a);
        if(a == '0') break;
        fputc(a,f);
        getchar();
    }
    fclose(f);

    char b;
    FILE *h;
    h = fopen("arq.txt", "r");
    if(h == NULL) {
        printf("Erro na abertura do arquivo!\n");
        exit(1);
    }
    while(1){
        if(feof(h)) break;
        
        b = fgetc(h);
        printf("%c", b);
    }
    printf("\n");
    fclose(h);
    return 0;
}