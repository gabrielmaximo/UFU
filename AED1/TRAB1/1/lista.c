#include "cabecalho.h"
struct lista{
	int vet[MAX];
	int fim;
};
Lista * cria_lista(){
	Lista *l;
	l= (Lista *) malloc(sizeof(Lista));
	if(l!=NULL) l->fim=0;
	return l;
}
int lista_vazia(Lista *l){
	if(l==NULL) return 0;
	if(l->fim==0) return 1;
	return 0;
}
int lista_cheia(Lista *l){
	if(l->fim>=MAX) return 1;
	return 0;
}
int insere_elem(Lista *l, int elem){
	if(l==NULL || lista_cheia(l)) return 0;
	Lista *temp = l;
	temp->vet[temp->fim++]=elem;
	return 1;
}
int remove_elem(Lista *l, int elem){
	if(l==NULL || lista_vazia(l)) return 0;
	Lista *temp = l;
	int i,j;
	for(i=0;i<temp->fim;i++){
		if(temp->vet[i]==elem) break;
	}
	if(i>=temp->fim) return 0;

	for(j=i;j<temp->fim-1;j++){
		temp->vet[j] = temp->vet[j+1];
	}
	return 1;
}
void imprimi_lista(Lista *l){
	int i;
	printf("Lista = {");
	for(i=0;i<l->fim;i++){
		if(i==l->fim-1) printf("%d",l->vet[i]);
		else printf("%d ",l->vet[i]);
	}
	printf("}\n");
}
int remove_todos(Lista *l,int elem){
	if(l==NULL||lista_vazia(l)) return 0;
	
	int i=0,j,controle=l->fim;

	while(i<l->fim)
	{
		if(l->vet[i]==elem){
			if(i==l->fim-1){
				l->fim--;
				return 1;
			}
			else{
				for(j=i;j<l->fim-1;j++){
					l->vet[j] = l->vet[j+1];
				}
				l->fim--;
			}
		}
		else i++;
	}
	if(l->fim<controle) return 1;
	return 0;
}
int inserir_inicio(Lista *l, int elem){
	if(l==NULL || lista_cheia(l)) return 0;
	Lista *temp = l;
	int i;
	for(i=temp->fim+1;i>0;i--){
		temp->vet[i] = temp->vet[i-1];
	}
	temp->vet[0]= elem;
	temp->fim++;
	return 1;	
}
int remove_impares(Lista *l){
	if(l==NULL||lista_vazia(l)) return 0;
	
	int i=0,j,controle=l->fim;

	while(i<l->fim)
	{
		if(l->vet[i]%2!=0){
			if(i==l->fim-1){
				l->fim--;
				return 1;
			}
			else{
				for(j=i;j<l->fim-1;j++){
					l->vet[j] = l->vet[j+1];
				}
				l->fim--;
			}
		}
		else i++;
	}
	if(l->fim<controle) return 1;
	return 0;
}
int menor(Lista *l){
	if(l==NULL || lista_vazia(l)) return 0;
	Lista *temp = l;
	int i,menor = (*temp).vet[0];
	for(i=0;i<(*temp).fim;i++){
		if((*temp).vet[i] < menor)menor=(*temp).vet[i];
	}
	return menor+1;// +1 pq  a lista pode ter o elem 0
}
int tamanho(Lista *l){
	if(l==NULL) return 0;
	return l->fim;
}
Lista * concatenar(Lista *A, Lista *B){
	//printf("CONCATENA\n");
	Lista *C = cria_lista();
	if(C==NULL) return NULL;
	int i,j;
	//printf("--\n");
	if(A->fim < MAX){
		//printf("-+\n");
		for(i=0;i<A->fim;i++){
			//printf("1\n");
			insere_elem(C,A->vet[i]);
		} 
		if(B->fim < MAX-A->fim){
			//printf("++\n");
			for(i=0;i<B->fim;i++){
				//printf("2\n");
				insere_elem(C,B->vet[i]);
			}
		}
		else return NULL;
		return C;
	}
	return NULL;
}