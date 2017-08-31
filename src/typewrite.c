#include <ctype.h>
#include <fcntl.h>
#include <linux/kd.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <time.h>
int main(int argc, char *argv[]) {
	int delayms = 50;
	bool sound = false;
	int console;
	char character;
	struct timespec delay = {0};
	if(argc >= 3 && !strcmp(argv[2], "sound")) {
		sound = true;
	}
	if(argc >= 2) {
		if(!strcmp(argv[1], "sound")) {
			sound = true;
		} else {
			delayms = atoi(argv[1]);
		}
	}
	delay.tv_nsec = delayms * 1000000;
	if(sound) {
		console = open("/dev/tty0", O_WRONLY);
	}
	while(character = getchar(), character != EOF) {
		putchar(character);
		fflush(stdout);
		if(!isspace(character) && sound) {
			ioctl(console, KDMKTONE, 339612);
		}
		nanosleep(&delay, NULL);
	}
	return 0;
}
