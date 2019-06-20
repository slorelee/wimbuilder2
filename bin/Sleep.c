#include <stdio.h>
#include <stdlib.h>
#include <windows.h>

int main(int argc, char* argv[]) {
    DWORD mSec = 1000;
    if (argc < 2) return 1;

    for (int sec = atoi(argv[1]); sec > 0; sec--) {
        Sleep(1000);
    }
    return 0;
}
