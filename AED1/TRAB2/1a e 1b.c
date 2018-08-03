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

int desempilha(pilha p, char *x){
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
        printf("%d ", f->v[i]);
    }
    printf("\b]\n");
    return 1;
}

int print_reverse(pilha f){
    if(f == NULL){
        printf("NULL\n");
        return 0;
    }
    int i;
    for(i = 0;  i <= 5; i++){
        printf("%d -> ", f->v[i]);
    }
    printf("NULL\n");
    return 1;
}

int palindrome(char *s){
    int i;
    char x;
    pilha p = cria_pilha();
    for(i = 0; s[i] != '\0'; i++){
        empilha(p, s[i]);
    }
    for(i = 0; s[i] != '\0'; i++){
        desempilha(p, &x);
        if(x != s[i]) return 0;
    }
    if(pilha_vazia(p)) return 1;
    return 0;
}

int main() {

    char s[10]= "UFo";
    
    if(palindrome(s)){
        printf("Hello World!\n");
    }

    return 0;
}