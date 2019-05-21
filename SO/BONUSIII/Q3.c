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
 	int a=3, esq=0, dir=0, x;

	printf("%d quer comer\n", i);
	while(!esq) esq = pega_garfo((i-1+N)%N);
	printf("%d pegou o garfo esquerdo\n", i);
	x = 3;
	sleep(x);

	while(!dir) dir = pega_garfo(i);
	printf("%d pegou o garfo direito\n", i);

	printf("%d vai comer\n", i);
	
	x = rand()%3;
	sleep(x);

	data_ptr->garfo[((i-1+N)%N)] = 1;
	data_ptr->garfo[i] = 1;

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
		data_ptr->fome[i] = 1;
	}

	for(i=0; i<N; i++) {
		int x = pthread_create(&filosofo[i], NULL, go, NULL);
              	
		if(x != 0) {
			puts("ERRO CRIAR THREAD!!!");
			exit(-1);
		}
	}
	
	for(i=0; i<N; i++) 
		pthread_join(filosofo[i], NULL);
}
