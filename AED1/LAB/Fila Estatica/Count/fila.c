#include "fila.h"

struct fila {
    int no[max];
    int ini, count;
};

Fila cria_fila(){
    Fila f;
    f = (Fila) malloc(sizeof(struct fila));
    if (f != NULL) {
        f->ini = 0;
        f->count = 0;
    }
    return f;
}

int fila_vazia(Fila f){
    if(f->count == 0) return 1;
    return 0;
}

int fila_cheia(Fila f){
    if(f->count == max) return 1;
    return 0;
}

int insere_fim(Fila f, int elem){
    if(fila_cheia(f)) return 0;
    f->no[(f->ini+f->count)%max] = elem;
    f->count++;
    return 1;
}

int remove_ini(Fila f, int *elem){
    if (fila_vazia(f) == 1) return 0;
    *elem = f->no[f->ini];
    f->ini = (f->ini+1)%max; 
    f->count--; 
    return 1; 
}

int print_fila(Fila f){
    int i = 0, aux = f->ini;
    if(fila_vazia(f)){
        printf("[NULL]\n");
        return 0;
    }
    while(i < f->count){
        printf("%d -> ", f->no[aux]);
        aux = (aux+1)%max;
        i++;
    }
    
    printf("NULL\n");
    return 1;

}