#include <fcntl.h> // For open()
#include <linux/kd.h> // For KIOCSOUND
#include <math.h> // For floor() and pow()
#include <stdlib.h> // For atoi()
#include <sys/ioctl.h> // For ioctl()
#include <time.h> // For nanosleep()
int main(int argc, char *argv[]) {
	/* Define the frequency of the fifth A */
	static const int a4 = 440;
	/* Open the current TTY */
	int console = open("/dev/tty0", O_WRONLY);
	/* Default settings */
	int key = 40;
	struct timespec duration = {1, 0};
	struct timespec delay = {0, 0};
	/* Use the first argument as the key number */
	if(argc >= 2) {
		key = atoi(argv[1]);
	}
	/* Use the second argument as the duration in milliseconds */
	if(argc >= 3) {
		int temp_duration = atoi(argv[2]);
		/*
			timespecs have two attributes, tv_sec and tv_nsec. tv_sec holds an amount of time in seconds,
			and tv_nsec holds an amount of nanoseconds to be added to that time. Since we take milliseconds,
			we have to do some trickery to make the timers work.
		*/
		duration.tv_sec = floor(temp_duration / 1000);
		temp_duration -= duration.tv_sec * 1000;
		duration.tv_nsec = temp_duration * 1000000;
	}
	/* Use the third argument as the delay in milliseconds */
	if(argc >= 4) {
		int temp_delay = atoi(argv[3]);
		delay.tv_sec = floor(temp_delay / 1000);
		temp_delay -= delay.tv_sec * 1000;
		delay.tv_nsec = temp_delay * 1000000;
	}
	/*
		There's a mathematical formula to calculate the frequency of a piano key depending
		on its number on an 88-key piano:

		f(n) = 2^((n - 49) / 12) * a
		(where n is the key number and a is the frequency of the fifth A, usually 440 Hz)

		So we can use that to get the frequency we want. But then we have to turn it into an
		argument that KIOCSOUND understands.

		As far as I understand, the PC speaker is controlled by a timer that takes a value,
		then decrements it each tick and turns the speaker on or off when it reaches zero.
		The timer runs at about 1,2 million ticks per second, or 1.2 MHz. If we divide the
		timer tick rate with the tone frequency we'll get a value that, when given to the
		timer, will make the PC speaker beep at roughly the specified frequency.
	*/
	/* Start beeping */
	ioctl(console, KIOCSOUND, (int)(1193180 / (pow(2, (float)(key - 49) / 12) * a4)));
	/* Wait for the desired duration*/
	nanosleep(&duration, NULL);
	/* Stop beeping */
	ioctl(console, KIOCSOUND, 0);
	/* Wait for the desired delay */
	nanosleep(&delay, NULL);
	/* Bye */
	return 0;
}
