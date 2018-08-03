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
int insere_ord(Lista *l, int elem){
	if(l==NULL||lista_cheia(l)) return 0;
	int i,j;
	for(i=0;i<l->fim;i++){
		if(elem<l->vet[i]) break;
	}
	if(i>l->fim-1){
		l->vet[i]=elem;;
		l->fim++;
		return 1;
	}
	else{
		for(j=l->fim;j>i;j--){
			l->vet[j] = l->vet[j-1];
		}
		l->vet[i]=elem;
		l->fim++;
		return 1;
	}
	return 0;
}
int remove_ord(Lista *l, int elem){
	if(l==NULL||lista_vazia(l))return 0;
	int i,j;
	for(i=0;i<l->fim;i++){
		if(l->vet[i]==elem){
			if(i==l->fim){
				l->fim--;
				return 1;
			}
			else{
				for(j=i;j<l->fim;j++){
					l->vet[j] = l->vet[j+1];
				}
				l->fim--;
				return 1;
			}
		}
	}
	return 0;
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

	if(l->vet[l->fim]>elem) return 0;//elem nao pertence a lista

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
int remove_pares(Lista *l){
	if(l==NULL||lista_vazia(l)) return 0;
	
	int i=0,j,controle=l->fim;

	while(i<l->fim)
	{
		if(l->vet[i]%2==0){
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
int maior(Lista *l){
	if(l==NULL || lista_vazia(l)) return 0;
	Lista *temp = l;
	int i,maior = (*temp).vet[0];
	for(i=0;i<(*temp).fim;i++){
		if((*temp).vet[i] > maior)maior=(*temp).vet[i];
	}
	return maior+1;// +1 pq  a lista pode ter o elem 0
}
int tamanho(Lista *l){
	if(l==NULL) return 0;
	return l->fim;
}
int iguais(Lista *A, Lista *B){
	if(A->fim!=B->fim) return 0; //nao sao iguais
	int i;
	for(i=0;i<A->fim;i++){
		if(A->vet[i]!=B->vet[i]) return 0;//elem diferentes
	}
	return 1;
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
			insere_ord(C,A->vet[i]);
		} 
		if(B->fim < MAX-A->fim){
			//printf("++\n");
			for(i=0;i<B->fim;i++){
				//printf("2\n");
				insere_ord(C,B->vet[i]);
			}
		}
		else return NULL;
		return C;
	}
	return NULL;
}