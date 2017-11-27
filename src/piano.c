#include <fcntl.h> // För open()
#include <linux/kd.h> // För KIOCSOUND
#include <math.h> // För floor() och pow()
#include <stdlib.h> // För atoi()
#include <sys/ioctl.h> // För ioctl()
#include <time.h> // För nanosleep()

/* Definiera ettstrukna A:s frekvens */
#define A4 440

int main(int argc, char *argv[]) {
	/* Öppna terminalen i skrivläge */
	int console = open("/dev/tty0", O_WRONLY);
	/* Grundinställningar */
	int key = 40;
	struct timespec duration = {1, 0};
	struct timespec delay = {0, 0};
	/* Den första parametern är numret på tangenten */
	if(argc >= 2) {
		key = atoi(argv[1]);
	}
	/* Den andra parametern är tonens längd i millisekunder */
	if(argc >= 3) {
		int temp_duration = atoi(argv[2]);
		/*
			timespec-strukter har två fält, tv_sec och tv_nsec. tv_sec innehåller ett antal
			sekunder och tv_nsec innehåller ett antal nanosekunder. Eftersom användaren
			matar in tonens längd i millisekunder behövs det lite trix för att få allt att funka.
		*/
		duration.tv_sec = floor(temp_duration / 1000);
		temp_duration -= duration.tv_sec * 1000;
		duration.tv_nsec = temp_duration * 1000000;
	}
	/* Den tredje parametern är en väntetid efter tonen, även den i millisekunder */
	if(argc >= 4) {
		int temp_delay = atoi(argv[3]);
		delay.tv_sec = floor(temp_delay / 1000);
		temp_delay -= delay.tv_sec * 1000;
		delay.tv_nsec = temp_delay * 1000000;
	}
	/*
		Det går att räkna ut en pianotangents frekvens beroende på dess nummer på ett 88-tangentspiano
		med den här enkla formeln:

		frekvens(nummer) = 2^((nummer - 49) / 12) * ettstrukna A:s frekvens (oftast 440Hz)

		Att göra om frekvensen till en KIOCSOUND-parameter är däremot mer komplicerat.
		PC-speakern styrs som jag har förstått det av ett chip som skapar en fyrkantsvåg. Det
		har ett register med ett antal klockcykler som motsvarar vågens period. Chippet har
		sedan urminnes tider (läs: IBM PC) haft en klockfrekvens på ungefär 1,2MHz. Dividerar
		man klockfrekvensen med tangentens frekvens får man antalet klockcykler per period.
		Matar man in det numret i chippet får det högtalaren att pipa med ungefär rätt frekvens.
	*/
	/* Börja pipa */
	ioctl(console, KIOCSOUND, (int)(1193180 / (pow(2, (float)(key - 49) / 12) * A4)));
	/* Sluta pipa när tonen ska ta slut */
	nanosleep(&duration, NULL);
	ioctl(console, KIOCSOUND, 0);
	/* Vänta */
	nanosleep(&delay, NULL);
	/* Hej då */
	return 0;
}
