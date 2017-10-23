#include <stdio.h> // For printf()
#include <stdlib.h> // For atoi(), rand() and srand()
#include <time.h> // For time()
#include <unistd.h> // For getpid()

int main(int argc, char* argv[]) {
	/* Declare variables */
	unsigned long num = 0;
	unsigned iter = 0;
	/* Try to use the first argument as the number */
	if(argc >= 2) {
		num = atoi(argv[1]);
	}
	/* Pick one at random if that didn't work */
	if(num <= 0) {
		srand(getpid() + time(NULL));
		num = rand();
		printf("Invalid starting number, using %lu instead.\n", num);
	}
	printf("%3u: %12lu\n", iter, num);
	/* Collatzate */
	while(num != 1) {
		iter++;
		/*
			If the number is even, divide it by two, otherwise multiply it by three
			and add one
		*/
		if(num % 2 == 0) {
			num = num / 2;
		} else {
			num = num * 3 + 1;
		}
		printf("%3u: %12lu\n", iter, num);
	}
	/* Return the number of iterations (this could overflow but whatever) */
	return iter;
}
