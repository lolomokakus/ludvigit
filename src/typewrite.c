#include <ctype.h> // For isspace()
#include <fcntl.h> // For open()
#include <linux/kd.h> // For KDMKTONE
#include <math.h> // For floor()
#include <stdbool.h> // For bool
#include <stdio.h> // For getchar(), putchar() and fflush()
#include <stdlib.h> // For atoi()
#include <string.h> // For strcmp()
#include <sys/ioctl.h> // For ioctl()
#include <time.h> // For nanosleep()
int main(int argc, char *argv[]) {
	/* Defaults */
	struct timespec delay = {0, 50000000}; // 50ms
	bool sound = false;
	/* Variables we'll need */
	int console;
	char character;
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
			int temp_delay = atoi(argv[1]);
			/* Convert milliseconds into seconds and nanoseconds */
			delay.tv_sec = floor(temp_delay / 1000);
			temp_delay -= delay.tv_sec * 1000;
			delay.tv_nsec = temp_delay * 1000000;
		}
	}
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
