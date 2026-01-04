// wincmd.cpp : Defines the entry point for the console application.
//

#include <Windows.h>

int WINAPI wWinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPWSTR lpCmdLine, int nCmdShow)
{
    TCHAR cmd[MAX_PATH + 1] = { 0 };
    DWORD ec = 0;
    PROCESS_INFORMATION ProcessInfo = { 0 };
    STARTUPINFO StartupInfo = { 0 };
    StartupInfo.cb = sizeof(StartupInfo);

    GetEnvironmentVariable(TEXT("ComSpec"), cmd, MAX_PATH);
    if (CreateProcess(cmd, lpCmdLine, NULL, NULL, FALSE, 0, NULL, NULL, &StartupInfo, &ProcessInfo)) {
        WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
        GetExitCodeProcess(ProcessInfo.hProcess, &ec);
        CloseHandle(ProcessInfo.hThread);
        CloseHandle(ProcessInfo.hProcess);
    } else {
        return GetLastError();
    }
    return ec;
}
