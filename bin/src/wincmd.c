// wincmd.cpp : Defines the entry point for the console application.
//

#include <Windows.h>

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
{
    char cmd[MAX_PATH + 1] = { 0 };
    PROCESS_INFORMATION ProcessInfo = { 0 };
    STARTUPINFOA StartupInfo = { 0 };
    StartupInfo.cb = sizeof(StartupInfo);

    GetEnvironmentVariable("ComSpec", cmd, MAX_PATH);
    if (CreateProcessA(cmd, lpCmdLine, NULL, NULL, FALSE, 0, NULL, NULL, &StartupInfo, &ProcessInfo)) {
        WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
        CloseHandle(ProcessInfo.hThread);
        CloseHandle(ProcessInfo.hProcess);
    } else {
      return GetLastError();
    }
    return 0;
}

