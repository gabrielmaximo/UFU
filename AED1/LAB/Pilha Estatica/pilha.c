 #include "pilha.h"
 #define max 64

struct pilha{
    int v[max];
    int top;
};

push cria_pilha(){
    push p;
    p = (push) malloc(sizeof(struct pilha));
    if(p != NULL)
        p->top = -1;
    else return 0;
    return p;
}

int pilha_vazia(push p){
    if(p->top == -1) return 1;

    return 0;
}

int pilha_cheia(push p){
    if(p->top == max-1) return 1;

    return 0;
}

int empilha(push p, int x){
    if(p == NULL || pilha_cheia(p)) return 0;
    p->top++;
    p->v[p->top] = x;
    return 1;
}

int desempilha(push p, int *x){
    if(p == NULL || pilha_vazia(p)) return 0;
    *x = p->v[p->top];
    p->top--;
    return 1;
}

int le_topo(push p, int *x){
    if(p == NULL || pilha_vazia(p)) return 0;
    *x = p->v[p->top];
    return 1;
}

int print_pilha(push f){
    if(f == NULL || pilha_vazia(f)) {
        printf("NULL\n");
        return 0;
    }
    int i;
    printf("[");
    for(i = f->top;i >= 0;i--){
        printf("%d ", f->v[i]);
    }
    printf("\b]\n");
    return 1;
}

int conversor(push *p, unsigned long long int x){
    if(*p == NULL || pilha_cheia(*p)) return -1;
    int count = 0;
    while(x > 0){
        if(!(empilha(*p,x%2))){
            *p = NULL;
            return 0;
        }
        count++;
        x /= 2;
    }
    return count;
}