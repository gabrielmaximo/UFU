#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <sys/types.h>
#include <sys/shm.h>
#include <time.h>
#include <unistd.h>

#define SIZE 4096
#define N 5

pthread_t filosofo[N];

typedef struct data{
	int garfo[N], fome[N];
}data;


key_t key = 111;
data *data_ptr;
void *shared = (void *)0;
int shmid;

void pensar() {
	int x = rand()%3;
	sleep(x);
}

int pega_garfo(int i) {
	if(!data_ptr->garfo[i]) {
		return 0;
	}

	data_ptr->garfo[i] = 0;
	return 1;
}

void comer(int i) {
 	int a=3, esq, dir;

	esq = pega_garfo((i-1+N)%N);
	dir = pega_garfo(i);

	if(!esq && !dir) {
		printf("%d eh um barbaro, esta comendo sem garfos\n", i); 
		a=0;
	}
	else if(!esq && dir) {
		printf("%d falhou miseravelmente tentando comer sem o garfo esquerdo\n", i);
		a=1;
	}
	else if(esq && !dir){
		 printf("%d fez bagunca comendo sem o garfo direito\n", i);
		a=2;
	} 
	else printf("%d consegue comer\n", i);

	int x = rand()%3;
	sleep(x);

	if(a == 3 || a == 2) data_ptr->garfo[((i-1+N)%N)] = 1;
	if(a == 3 || a == 1) data_ptr->garfo[i] = 1;

	printf("%d terminou de comer\n", i);
	data_ptr->fome[i] = 0;
	pensar();
}

void * go() {
	int x, i;

	for(i=0; i<N; i++)
		if(pthread_self() == filosofo[i]) {
			x = i;
			break;
		}

	while(1) {
		if(rand() % 2 && !data_ptr->fome[i])pensar();
		else comer(x);
	}
}


int main()
{	
	int i;

	srand(time(NULL));


	shmid = shmget(key, SIZE,0666|IPC_CREAT);

	if(shmid == -1) {
		printf("ERRO DE COMPARTILHAMENTO DE MEMORIA\n");
		exit(-1);
	}

	shared = shmat(shmid, (void*)0,0);

	if (shared == (void *) -1 )
	{
		printf("ERRO ENDERECAMENTO MEMORIA COMPARTILHADA\n");
		exit(-1);
	}

	data_ptr = (data*) shared;


	for(i=0; i<N; i++) {
		data_ptr->garfo[i] = 1;
		data_ptr->fome[i] = 0;
	}

	for(i=0; i<N; i++) {
		int x = pthread_create(&(filosofo[i]), NULL, go(), NULL);
              	
		if(x != 0) {
			puts("ERRO CRIAR THREAD!!!");
			exit(-1);
		}
	}
	
	for(i=0; i<N; i++) 
		pthread_join(filosofo[i], NULL);
}
