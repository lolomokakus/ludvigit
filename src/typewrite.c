#include <ctype.h> // For isspace()
#include <fcntl.h> // For open()
#include <linux/kd.h> // For KDMKTONE
#include <stdbool.h> // For bool
#include <stdio.h> // For getchar(), putchar() and fflush()
#include <stdlib.h> // For atoi()
#include <string.h> // For strcmp()
#include <sys/ioctl.h> // For ioctl()
#include <time.h> // For nanosleep()
int main(int argc, char *argv[]) {
	/* Defaults */
	int delayms = 50; // 50ms
	bool sound = false;
	/* Variables we'll need */
	int console;
	char character;
	struct timespec delay = {0};
	/* If there are two or mode arguments and the second one is "sound", turn on the sound */
	if(argc >= 3 && !strcmp(argv[2], "sound")) {
		sound = true;
	}
	/* If there are one or more arguments */
	if(argc >= 2) {
		/* If the first argument is "sound", turn on the sound, otherwise try to use the argument as the delay */
		if(!strcmp(argv[1], "sound")) {
			sound = true;
		} else {
			delayms = atoi(argv[1]);
		}
	}
	/* If using the argument as the delay failed, fall back to the default */
	if(!delayms) {
		delayms = 50;
	}
	/* Convert the delay into nanoseconds for nanosleep() */
	delay.tv_nsec = delayms * 1000000;
	/* Open the current TTY for writing if sound is enabled */
	if(sound) {
		console = open("/dev/tty0", O_WRONLY);
	}
	/* Go through each character in the standard input */
	while(character = getchar(), character != EOF) {
		/* Print it */
		putchar(character);
		/* Flush the stdout buffer */
		fflush(stdout);
		/* Make some noise if the current character isn't whitespace and noisemaking is enabled */
		if(!isspace(character) && sound) {
			/* Beeps at 100Hz for 5ms (I say "beeps" but it sounds more like a click) */
			ioctl(console, KDMKTONE, 339612);
		}
		/* Delay printing the next character */
		nanosleep(&delay, NULL);
	}
	/* Bye */
	return 0;
}
