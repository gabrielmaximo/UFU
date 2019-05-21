#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <time.h>
#include <unistd.h>

#define N 5

pthread_t filosofo[N];
int garfo[N], status[N];
sem_t s[N], mutex;


void pensa() {
	int x = rand()%3;
	sleep(x);
}	

void come(){
	int x = rand()%3;
	sleep(x);
}

void teste(int i) {
	if(status[i] == 1 && status[(i+1)%N] != 2 &&  status[(i-1+N)%N] != 2) {
		status[i] = 2;
		sem_post(&s[i]);
	}
}

void pega_garfos(int i) {
	sem_wait(&mutex);
	status[i] = 1;
	teste(i);
	sem_post(&mutex);
	sem_wait(&s[i]);
}

void coloca_garfos(int i) {
	sem_wait(&mutex);
	status[i] = 0;
	teste((i+1)%N);
	teste((i-1+N)%N);
	sem_post(&mutex);
}

void * go() {
	int x, i;

	for(i=0; i<N; i++)
		if(pthread_self() == filosofo[i]) {
			x = i;
			break;
		}

	while(1) {
		pensa();
		printf("%d quer comer\n", x);
		pega_garfos(x);
		printf("%d esta comendo\n", x);
		come();
		coloca_garfos(x);
		printf("%d terminou de comer\n", x);
	}
}


int main()
{	
	int i;

	srand(time(NULL));

	for(i=0; i<N; i++)
		sem_init(&s[i], 0, 1);

	sem_init(&mutex, 0, 1);

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
