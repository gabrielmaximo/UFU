 #include <stdio.h>
 #include <stdlib.h>
 #define max 64

struct pilha{
    int v[max];
    int top;
};

typedef struct pilha *pilha;

pilha cria_pilha(){
    pilha p;
    p = (pilha) malloc(sizeof(struct pilha));
    if(p != NULL)
        p->top = -1;
    else return 0;
    return p;
}

int pilha_vazia(pilha p){
    if(p->top == -1) return 1;

    return 0;
}

int pilha_cheia(pilha p){
    if(p->top == max-1) return 1;

    return 0;
}

int empilha(pilha p, int x){
    if(p == NULL || pilha_cheia(p)) return 0;
    p->top++;
    p->v[p->top] = x;
    return 1;
}

int desempilha(pilha p, int *x){
    if(p == NULL || pilha_vazia(p)) return 0;
    *x = p->v[p->top];
    p->top--;
    return 1;
}

int le_topo(pilha p, int *x){
    if(p == NULL || pilha_vazia(p)) return 0;
    *x = p->v[p->top];
    return 1;
}

int print_pilha(pilha f){
    if(f == NULL || pilha_vazia(f)) {
        printf("NULL\n");
        return 0;
    }
    int i;
    printf("[");
    for(i = f->top;i >= 0;i--){
        printf("%d ", &f->v[i]);
    }
    printf("\b]\n");
    return 1;
}

int conversor(pilha *p, unsigned long long int x, unsigned int op){
    if(*p == NULL || !pilha_vazia(*p) || op != 1 || op != 2) return -1;
    int count = 0;
    
    if(op == 1){
        while(x > 0){
            if(!(empilha(*p,x%2))){
                *p = NULL;
                return 0;
            }
            count++;
            x /= 2;
        }
    }
    if(op == 2){
        while(x > 0){
            if(!empilha(*p, x%8)){
                *p = NULL;
                return 0;
            }
            count++;
            x /= 8;
        }
    }
    return count; // retorna o numero de bits ou o numero de casas do octal
}

int main() {

    pilha p = cria_pilha();
    print_pilha(p);
    conversor(&p, 42, 1);
    print_pilha(p);

    return 0;
}