#include <windows.h>

#define strnlen_s(str, size) strnlen((str))
#define _tcscat_s(dest, size, src) strcat((dest), (src))

int main(int argc, char **argv)
{
    int len = 0;
    TCHAR bufCmd[MAX_PATH] = TEXT("cmd /d ");
    LPTSTR szCmdline = GetCommandLine();
    STARTUPINFO si;
    PROCESS_INFORMATION pi;

    ZeroMemory(&si, sizeof(si));
    si.cb = sizeof(si);
    ZeroMemory(&pi, sizeof(pi));

    len = strnlen_s(argv[0], MAX_PATH);
    if (szCmdline[0] == TEXT('\"')) len += 2;
    _tcscat_s(bufCmd, MAX_PATH - 7, szCmdline + len + 1);
    // wprintf(TEXT("Cmdline %s\r\n"), bufCmd);
    // start the cmd.exe process with /d.
    if (!CreateProcess(NULL, bufCmd, NULL, NULL, FALSE,
                       0, NULL, NULL, &si, &pi)) {
        printf("CreateProcess failed(%d).\n", GetLastError());
        return 1;
    }
    WaitForSingleObject(pi.hProcess, INFINITE);
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
    return 0;
}
