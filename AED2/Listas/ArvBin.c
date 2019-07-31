//ArvBin.c    https://pt.wikibooks.org/wiki/Programar_em_C/Árvores_binárias
#include <stdio.h>
#include <stdlib.h>

typedef struct No* ArvBB;

struct No{
    int info;
    ArvBB esq;
    ArvBB dir;
};

ArvBB* criarArvore(){
    ArvBB *pRaiz = (ArvBB*) malloc(sizeof(ArvBB)); 
    if(pRaiz != NULL) 
        *pRaiz = NULL;
    return pRaiz;
}

void insercao(ArvBB *pRaiz, int n){
	if (*pRaiz == NULL)
	{
	      *pRaiz=(ArvBB)malloc(sizeof (struct No));
	      (*pRaiz)->esq=NULL;
	      (*pRaiz)->dir=NULL;
	      (*pRaiz)->info=n;
	}
	else 
        {
		if (n < ((*pRaiz)->info))
		{
			insercao(&((*pRaiz)->esq), n);
		}
		else
		{
			insercao(&((*pRaiz)->dir), n);
		}
	}
}

void exibirEmOrdem(ArvBB pRaiz){
    if(pRaiz != NULL){
        exibirEmOrdem(pRaiz->esq);
        printf("\n%i", pRaiz->info);
        exibirEmOrdem(pRaiz->dir);
    }
}

void exibirPreOrdem(ArvBB pRaiz){
    if(pRaiz != NULL){
        printf("\n%i", pRaiz->info);
        exibirPreOrdem(pRaiz->esq);
        exibirPreOrdem(pRaiz->dir);
    }
}

void exibirPosOrdem(ArvBB pRaiz){
    if(pRaiz != NULL){
        exibirPosOrdem(pRaiz->esq);
        exibirPosOrdem(pRaiz->dir);
        printf("\n%i", pRaiz->info);
    }
}

int contarNos(ArvBB pRaiz){
   if(pRaiz == NULL)
        return 0;
   else
        return 1 + contarNos(pRaiz->esq) + contarNos(pRaiz->dir);
}

int contarFolhas(ArvBB pRaiz){
   if(pRaiz == NULL)
        return 0;
   if(pRaiz->esq == NULL && pRaiz->dir == NULL)
        return 1;
   return contarFolhas(pRaiz->esq) + contarFolhas(pRaiz->dir);
}

int maior(int a, int b){ //função auxiliar para facilitar o calculo da altura
    if(a > b)
        return a;
    else
        return b;
}

int altura(ArvBB pRaiz){
   if((pRaiz == NULL) || (pRaiz->esq == NULL && pRaiz->dir == NULL))
       return 1;
   else
       return 1 + maior(altura(pRaiz->esq), altura(pRaiz->dir));
}

int maiorElem (ArvBB pRaiz){
    if(pRaiz == NULL) return -1;
    if(pRaiz->dir == NULL) return pRaiz->info;
    maiorElem(pRaiz->dir);
}

int menorElem (ArvBB pRaiz){
    if(pRaiz == NULL) return -1;
    if(pRaiz->esq == NULL) return pRaiz->info;
    menorElem(pRaiz->esq);
}

int consultaValor(ArvBB pRaiz, int val){
    if(pRaiz != NULL){
        if(pRaiz->info > val) return consultaValor(pRaiz->esq, val);
        else if(pRaiz->info < val) return consultaValor(pRaiz->dir, val);
        else return 1;
    }

    return 0;
}

int exibirPares(ArvBB pRaiz){
    if(pRaiz == NULL)
        return 0;
    exibirPares(pRaiz->esq);
    if(pRaiz->info % 2 == 0) printf("%d -> ", pRaiz->info);
    exibirPares(pRaiz->dir);
    
}

int contarNosPares(ArvBB pRaiz){
    if(pRaiz == NULL)
        return 0;
    else if(pRaiz->info % 2 == 0)
        return 1 + contarNosPares(pRaiz->esq) + contarNosPares(pRaiz->dir);
    return 0 + contarNosPares(pRaiz->esq) + contarNosPares(pRaiz->dir);
}