#include "SkipList.c"

skiplist* criaSkipList(skiplist *l);

int rand_level();

int tamanhoSkipList(skiplist *l);

int vaziaSkipList(skiplist *l);

int insereSkipList(skiplist *l, int chave, int val);

int buscaSkipList(skiplist *l, int chave);

void liberaSkipList(no *x);

int removeSkipList(skiplist *l, int chave);

void imprimeSkipList(skiplist *l);