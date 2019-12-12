//from: http://www.msfn.org/board/Tool-Hide-console-command-line-windows-t49184.html
//compile: cl.exe hiderun.cpp /GA /O1 /link /subsystem:windows kernel32.lib advapi32.lib user32.lib
//compile: cl hiderun.cpp hiderun.res /GA /O1 /link /subsystem:windows kernel32.lib advapi32.lib user32.lib

#include <process.h> 
#include <windows.h>

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
{ 
	STARTUPINFO si; 
	PROCESS_INFORMATION pi; 
	int bWait = 0;
	DWORD exitcode = 0;
	char stopchar = ' ';
	char* lpszCmd = GetCommandLine();

	if (lpszCmd[0] == '\"') stopchar = '\"'; 
	do { lpszCmd++; } while ((lpszCmd[0] != stopchar) && (lpszCmd[0] != 0));
	if (lpszCmd[0] != 0)
	{
  do { lpszCmd++; }
  while ((lpszCmd[0] != 0) && ((lpszCmd[0] == ' ') || (lpszCmd[0] == '\t')));
	};
	if (lpszCmd[0] == 0) 
	{
  MessageBox(0, "about:\n\nhiderun.exe hides console window of started program & waits (opt.) for its termination\n\nUsage:\n\n\thiderun.exe [/w] <filename>\n\nWhere:\n\n/w\twait for program termination\nfilename\texecutable file name", "Error: Incorrect usage", 0);
  ExitProcess(0);
	};

	if ((lpszCmd[0] == '/')&&(((lpszCmd[1])|0x20) == 'w')&&(lpszCmd[2] == ' '))
	{ 
  bWait = 1; 
  lpszCmd += 3; 
	};
	while ((lpszCmd[0] != 0) && ((lpszCmd[0] == ' ') || (lpszCmd[0] == '\t'))) lpszCmd++;

	/* create process with new console */ 
	unsigned char *ps = (unsigned char*)&si;
	for (unsigned int i = 0; i < sizeof(si); i++) ps[ i ] = 0x00;
 
	si.cb = sizeof(si); 
	si.dwFlags = STARTF_USESHOWWINDOW; 
	si.wShowWindow = SW_HIDE; 
	if( CreateProcess( NULL, lpszCmd, 
        NULL, NULL, FALSE, CREATE_NEW_CONSOLE, 
        NULL, NULL, & si, & pi ) ) 
	{ 
  if (bWait) WaitForSingleObject(pi.hProcess, INFINITE);
  CloseHandle( pi.hProcess ); 
  CloseHandle( pi.hThread ); 
	}
	else
  exitcode = GetLastError();
 
	/* terminate this */ 
	ExitProcess(exitcode);
}
