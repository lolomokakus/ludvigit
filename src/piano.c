#include <fcntl.h> // For open()
//#include <linux/kd.h> // For KIOCSOUND
#include <math.h> // For pow()
#include <stdlib.h> // For atoi()
#include <sys/ioctl.h> // For ioctl()
#include <time.h> // For nanosleep()
int main(int argc, char *argv[]) {
	static const int a4 = 440;
	int console = open("/dev/tty0", O_WRONLY);
	int key = 40;
	struct timespec duration = {1, 0};
	struct timespec delay = {0, 0};
	if(argc >= 2) {
		key = atoi(argv[1]);
	}
	if(argc >= 3) {
		duration.tv_sec = 0;
		duration.tv_nsec = atoi(argv[2]) * 1000000;
	}
	if(argc >= 4) {
		delay.tv_nsec = atoi(argv[3]) * 1000000;
	}
	ioctl(console, KIOCSOUND, (int)(1193180 / (pow(2, (float)(key - 49) / 12) * a4)));
	nanosleep(&duration, NULL);
	ioctl(console, KIOCSOUND, 0);
	nanosleep(&delay, NULL);
	return 0;
}
