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
	bool sound = false;
	int delayms = 50;
	int console;
	char character;
	struct timespec delay;
	delay.tv_sec = 0;
	if(argc >= 3) {
		if(strcmp(argv[2], "sound")) {
			sound = true;
		}
	}
	if(argc >= 2 && atoi(argv[1]) >= 5) {
		delayms = atoi(argv[1]);
	}
	delay.tv_nsec = (delayms - 5) * 1000000;
	if(sound) {
		console = open("/dev/console", O_WRONLY);
	}
	while(character = getchar(), character != EOF) {
		putchar(character);
		fflush(stdout);
		if(!isspace(character) && sound) {
			ioctl(console, KIOCSOUND, 1193);
			nanosleep((const struct timespec[]){{0, 5000000}}, NULL);
			ioctl(console, KIOCSOUND, 0);
		}
		nanosleep(&delay, NULL);
	}
	return 0;
}
