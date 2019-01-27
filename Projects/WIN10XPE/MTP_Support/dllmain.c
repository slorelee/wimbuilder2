#include<windows.h>

int ModifyMiniNT() {
    TCHAR szFileName[MAX_PATH] = {0};
    GetModuleFileName(NULL, szFileName, MAX_PATH);
    if (wcsncmp(szFileName, L"X:\\windows\\system32\\winlogon.exe", 32) == 0) {
        HKEY dmy;
        RegDeleteKey(HKEY_LOCAL_MACHINE, L"SYSTEM\\CurrentControlSet\\Control\\MiniNT");
        Sleep(3000);
        RegCreateKey(HKEY_LOCAL_MACHINE, L"SYSTEM\\ControlSet001\\Control\\MiniNT", &dmy);
    }
    return 0;
}


BOOL APIENTRY DllMain(HMODULE hModule,
                      DWORD  ul_reason_for_call,
                      LPVOID lpReserved
)
{
    switch (ul_reason_for_call) {
    case DLL_PROCESS_ATTACH:
        ModifyMiniNT();
        break;
    case DLL_THREAD_ATTACH:
    case DLL_PROCESS_DETACH:
    case DLL_THREAD_DETACH:
        break;
    }
    return TRUE;
}
