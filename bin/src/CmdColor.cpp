/*
 * Colorizes standard output on Windows
 * https://github.com/jeremejevs/cmdcolor
 */

#include <signal.h>
#include <cstring>
#include <iostream>
#include <sstream>
#include <string>
#include <windows.h>

using std::cin;
using std::cout;
using std::string;
using std::ostringstream;

HANDLE con;
CONSOLE_SCREEN_BUFFER_INFO definfo;
ostringstream tmpins;
const int ntow[] = { 0, 4, 2, 6, 1, 5, 3, 7 };

void rawget(char &c) {
    if (!cin.get(c).good()) {
        throw -1;
    }
}

void append(char c) {
    tmpins << c;
}

void get(char &c) {
    rawget(c);
    append(c);
}

void reset() {
    tmpins.str(string());
    tmpins.clear();
}

void dump() {
    cout << tmpins.str();
    reset();
}

int parse(bool *fore) {
    char c, d;
    get(c);
    c -= '0';
    if (c == 0) {
        throw -3;
    }

    get(d);
    d -= '0';
    if (c == 1) {
        if (d != 0) {
            throw -2;
        }
        get(d);
        d -= '0';
    }

    if (d < 0 || d > 7) {
        throw -2;
    }

    int res = ntow[d];
    switch (c) {
        case 3: {
            *fore = true;
            return res;
        }
        case 4: {
            *fore = false;
            return res << 4;
        }
        case 9: {
            *fore = true;
            return res + 8;
        }
        case 1: {
            *fore = false;
            return (res + 8) << 4;
        }
        default: {
            throw -2;
        }
    }
}

void bye(int sig=0) {
    if (con != NULL) {
        SetConsoleTextAttribute(con, definfo.wAttributes);
    }

    exit(0);
}

int main() {
    signal(SIGABRT, &bye);
    signal(SIGINT, &bye);
    signal(SIGTERM, &bye);
    SetErrorMode(SEM_FAILCRITICALERRORS | SEM_NOGPFAULTERRORBOX);
    con = GetStdHandle(STD_OUTPUT_HANDLE);
    GetConsoleScreenBufferInfo(con, &definfo);
    try {
        char c;
        while (true) {
            try {
                rawget(c);
                if (c != '\\' && c != 27) {
                    cout << c;
                    continue;
                }

                append(c);
                if (c == '\\') {
                    get(c);
                    if (c != '0') {
                        throw -2;
                    }
                    get(c);
                    if (c != '3') {
                        throw -2;
                    }
                    get(c);
                    if (c != '3') {
                        throw -2;
                    }
                    c = 27;
                }
                else if (c != 27) {
                    throw -2;
                }

                get(c);
                if (c != '[') {
                    throw -2;
                }

                int res = 0;
                bool fore;
                do {
                    try {
                        res = parse(&fore) + (res & (fore ? 0xF0 : 0x0F));
                    }
                    catch (int e) {
                        if (-3 == e) {
                            res = definfo.wAttributes;
                        }
                        else {
                            throw;
                        }
                    }

                    get(c);
                } while (c == ';');

                if (c != 'm') {
                    throw -2;
                }

                SetConsoleTextAttribute(con, res);
                reset();
            }
            catch (int e) {
                if (-2 == e) {
                    dump();
                    continue;
                }
                else {
                    throw;
                }
            }
        }
    }
    catch (int e) {
    }

    bye();
    return 0;
}
