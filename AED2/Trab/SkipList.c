#include <stdlib.h>
#include <stdio.h>
#include <limits.h>

// SkipList.c
//Grupo L --> Integrantes: Luis Gabriel Maximo --> matrícula 11721BCC027

#define MAX_LEVEL 6

    //A estrutura de dados da skip list escolhida abaixo baseado na criterio de praticidade para a 
    //implementação (vetor de ponteiros)
typedef struct no {
    int chave;
    int val;
    struct no **prox;
} no;

typedef struct skiplist {
    int level;
    int tam;
    struct no *cab;
} skiplist;

// Função abaixo cria e inicializa a skip List, sendo necessário na main, 
//apenas criar um struct skiplist e passar como parametro dessa função
skiplist* criaSkipList(skiplist *l){
    int i;
    no *cab = (no *)malloc(sizeof(struct no));
    l->cab = cab;
    cab->chave = INT_MAX;
    cab->prox = (no **)malloc(sizeof(no*) * (MAX_LEVEL+1));
    for (i = 0; i <= MAX_LEVEL; i++) {
        cab->prox[i] = l->cab;
    }

    l->level = 1;
    l->tam = 0;

    return l;
}

// aqui é uma função feita para gerar os leveis usado a inserção, o level 
//indica as alturas da minha skip list e que define em qual level ira ocorrer a inserção
// foi usada a função rand() da biblioteca limits.h para implementação dessa função, que ira
// gerar inteiros aleatorios dentro de um intervalo especifico, para interação com o level
// se o numero aleatorio gerado, for menor que a constant maxima da função rand / 2 e ainda
// o level ser menor que o level total, ai eu incremento o level e poderei inserir o novo val
// no level abaixo conforme a necessidade da skip list implementada na função insere.
int rand_level(){
    int level = 1;
    while (rand() < RAND_MAX/2 && level < MAX_LEVEL)
        level++;
    return level;
}

// Função simples que retorna o tamanho da minha skip List, toda vez que um elemento é inserido
// na lista, eu atualizo o campo tam, feito na struct acima e retorno por essa função
int tamanhoSkipList(skiplist *l){
    if(l != NULL) return l->tam;
    return -1;
}

// Outra função Simples que apenas verifica se o tamanho é zero, se for retorno 1, afirmando que
// a lista está vazia, caso contrário retornará 0
int vaziaSkipList(skiplist *l){
    if(l->tam == 0) return 1;
    return 0;
}

// Função insere foi baseado nos critérios padroes de inserção de uma skip List, onde alem
// da lista, é preciso passar uma chave e o valor a ser inserido, possui
// algumas verificações de validação, a primeira verifica se não há elementos na chave escolhida para
// fazer a inserção, caso exista, o elemento não pode ser inserido naquela posição pois aquela chave ja
// corresponde a um valor, o que invalida a inserção, sendo necessario inserir outra chave.
// caso seja possivel inserir, sera gerado uma posição em level randomicamente e o campo level da struct
// sera atualizado se o level randomizado para essa inserção for maior que o level ja contido na estrutura
// e então aux o level, em seguida a função usa um campo cab, que seria dedicado ao cabeçalho, um campo
// auxiliar usado para armazenar algum valor temporariamente, no caso ele armazena o começo da lista. Apos isso
// o campo tam que armazena o tamanho da lista tambem é atualizado se a inserção for efetuada.
// os demais passos são de criação de um novo nó e preparação para a inserção do mesmo, apos iniciado todos os
// campos do novo nó, ele é inserido no level designado, e para isso ocorre um percorrimento até essa possição
// partindo do nivel 1, também é usado um ponteiro auxiliar para ajudar no percorrimento e para não perder a posição
// dos nós, após tudo isso é feito a inserção no devido level gerado pela rand_level() e na mesma posição do level
int insereSkipList(skiplist *l, int chave, int val){
    no *aux[MAX_LEVEL+1];
    no *x = l->cab;
    int i, level;
    for (i = l->level; i >= 1; i--) {
        while (x->prox[i]->chave < chave)
            x = x->prox[i];
        aux[i] = x;
    }
    x = x->prox[1];

    if (chave == x->chave) {
        x->val = val;
        return 0;
    } else {
        level = rand_level();
        if (level > l->level) {
            for (i = l->level+1; i <= level; i++) {
                aux[i] = l->cab;
            }
            l->level = level;
        }
        l->tam++;
        x = (no *)malloc(sizeof(no));
        x->chave = chave;
        x->val = val;
        x->prox = (no **)malloc(sizeof(no*) * (level + 1));
        for (i = 1; i <= level; i++) {
            x->prox[i] = aux[i]->prox[i];
            aux[i]->prox[i] = x;
        }
    }
    return 0;
}

// A operação de busca, percorre apartir do ultimo level e vem voltando procurando o elemento pela chave
// ela nada mais faz do que verificar se a chave possui um valor, se sim, ela retorna que existe um valor
// naquela chave correspondente, mas não retorna o valor e sim que aquela chave possui um valor atrelado a ela
// é usado um ponteiro auxiliar chamado de x, para percorrer a lista na busca.
int buscaSkipList(skiplist *l, int chave){
    no *x = l->cab;
    int i;
    for (i = l->level; i >= 1; i--) {
        while (x->prox[i]->chave < chave)
            x = x->prox[i];
    }
    if (x->prox[1]->chave == chave) {
        return 1;
    } else {
        return 0;
    }
    return 0;
}

// Função libera, verifica se o nó não é NULL, se não for Null, libera o proximo 
// nó e também o nó atual, (feita para ser usada recursivamente ou dentro de um loop com algumas chamadas)
// o motivo da libera ser dessa forma, foi versatilidade para usa-la de outras formas, como na remoção essa.
// função não libera todos os nós alocados na lista, tentei fazer a libera para remover e desalocar tudo, porem
// ocorreram alguns erros de pointer type e demais fatores que fizeram com que nao funcionasse da outra forma,
// então mantive uma libera simples que atua sobre um caso base, assim consigo chamar ela dentro de um loop e 
// percorrer a lista liberando nó a nó.
void liberaSkipList(no *x){
    if (x) {
        free(x->prox);
        free(x);
    }
}

//  Função remove é baseado na remoção atráves da chave, usei 2 ponteiros auxiliares para poder realizar
// as buscas e condicionamentos, inicialmente o ponteiro auxiliar x recebe o inico da lista, e o outro
// os leveis, aqui é usado a função libera para realizar a remoção, o busca pelo elemento a ser removido
// é feita usando a chave passada como parametro em um loop usando os auxiliares que procura o elemento pela
// chave no devido level correspondente, o que torna a complexidade O(log n) conforme a definição de skip list
// o campo tam é decrementado para poder atualizar o tamanho, e caso o level não possua valores, ele também é
// decrementado e atualizado.
int removeSkipList(skiplist *l, int chave){
    int i;
    no *aux[MAX_LEVEL + 1];
    no *x = l->cab;
    for (i = l->level; i >= 1; i--) {
        while (x->prox[i]->chave < chave)
            x = x->prox[i];
        aux[i] = x;
    }

    x = x->prox[1];
    if (x->chave == chave) {
        for (i = 1; i <= l->level; i++) {
            if (aux[i]->prox[i] != x)
                break;
            aux[i]->prox[1] = x->prox[i];
        }
        liberaSkipList(x);
        l->tam--;

        while (l->level > 1 && l->cab->prox[l->level] == l->cab)
            l->level--;
        return 0;
    }
    return 1;
}

// Função simples para imprimir cada elem da Lista, ela percorre a lista, passando por todos os elem
// e imprimi as chaves e os elementos correspondentes, é usado um ponteiro auxiliar chamado de x, para
// poder executar o percorrimento condicionado. 
void imprimeSkipList(skiplist *l){
    no *x = l->cab;
    while (x && x->prox[1] != l->cab) {
        printf("%d[%d]->", x->prox[1]->chave, x->prox[1]->val);
        x = x->prox[1];
    }
    printf("NULL\n");
}


// Uma Função main simples para testar função por função, favor desconsiderar caso necessário.
int main(){
    int arr[] = {3, 6, 9, 2, 11, 1, 4}, i;
    skiplist l;
    criaSkipList(&l);

    printf("Inserir o conjunto: {3, 6, 9, 2, 11, 1}\n");
    for (i = 0; i < sizeof(arr)/sizeof(arr[0]); i++) {
        insereSkipList(&l, arr[i], arr[i]);
    }
    imprimeSkipList(&l);

    printf("Realizando Buscas nas chaves {3, 4, 7, 10, 111}:\n");
    int keys[] = {3, 4, 7, 10, 111};

    for (i = 0; i < sizeof(keys)/sizeof(keys[0]); i++) {
        int x = buscaSkipList(&l, keys[i]);
        if (x) {
            printf("Existe Valor atrelado a chave %d na lista\n", keys[i]);
        } else {
            printf("NÃO EXISTE Valor atrelado a chave %d\n", keys[i]);
        }
    }

    printf("Remover valor na chave 3 e exibir a SkipList:\n");
    removeSkipList(&l, 3);
    removeSkipList(&l, 9);
    imprimeSkipList(&l);
    int t = tamanhoSkipList(&l);
    printf("O tamanho da SkipList é = %d\n", t);
    return 0;
}