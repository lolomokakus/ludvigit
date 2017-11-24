#include <ctype.h> // För isspace()
#include <fcntl.h> // För open()
#include <linux/kd.h> // För KDMKTONE
#include <math.h> // För floor()
#include <stdbool.h> // För bool
#include <stdio.h> // För getchar(), putchar() och fflush()
#include <stdlib.h> // För atoi()
#include <string.h> // För strcmp()
#include <sys/ioctl.h> // För ioctl()
#include <time.h> // För nanosleep()

int main(int argc, char *argv[]) {
	/* Grundinställningar */
	struct timespec delay = {0, 50000000}; // 50ms
	bool sound = false;
	/* Variabler som kommer behövas */
	int console;
	char character;
	/* Slå på klicken om det finns två eller fler parametrar och den andra är "sound" */
	if(argc >= 3 && !strcmp(argv[2], "sound")) {
		sound = true;
	}
	/*
		Slå på klicken om den första parametern är "sound" och försök annars tolka den
		som en väntetid i millisekunder
	*/
	if(argc >= 2) {
		if(!strcmp(argv[1], "sound")) {
			sound = true;
		} else {
			int temp_delay = atoi(argv[1]);
			/* Konvertera millisekunderna till sekunder och nanosekunder */
			delay.tv_sec = floor(temp_delay / 1000);
			temp_delay -= delay.tv_sec * 1000;
			delay.tv_nsec = temp_delay * 1000000;
		}
	}
	/* Öppna terminalen i skrivläge om klicken är aktiverade */
	if(sound) {
		console = open("/dev/tty0", O_WRONLY);
	}
	/* Gå igenom alla tecken i stdin */
	while(character = getchar(), character != EOF) {
		/* Skriv ut tecknet */
		putchar(character);
		/* Kläm ut det ur bufferten */
		fflush(stdout);
		/* Klicka om klicken är påslagna och tecknet inte är mellanslag el. dyl. */
		if(!isspace(character) && sound) {
			/* Piper med 100Hz i 5ms (det låter snarare som ett klick) */
			ioctl(console, KDMKTONE, 339612);
		}
		/* Vänta med att skriva ut nästa bokstav */
		nanosleep(&delay, NULL);
	}
	/* Hej då */
	return 0;
}
