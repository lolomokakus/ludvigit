#include <stdio.h>
#include <stdlib.h>
#include <time.h>
int main(int argc, char *argv[]) {
	int character;
	struct timespec delay;
	delay.tv_sec = 0;
	if(argc < 2) {
		delay.tv_nsec = 50000000;
	} else {
		delay.tv_nsec = atoi(argv[1]) * 1000000;
	}
	while(character = getchar(), character != EOF) {
		putchar(character);
		fflush(stdout);
		nanosleep(&delay, NULL);
	}
	return 0;
}
