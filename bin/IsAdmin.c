/*
 * How To Determine Whether a Thread Is Running in User Context of Local Administrator Account
 * https://support.microsoft.com/en-us/kb/118626
 */

#include <windows.h>
//#include <stdio.h>
#include <lmcons.h>

BOOL IsCurrentUserLocalAdministrator(void);

void main(int argc, char **argv)
{
    if (IsCurrentUserLocalAdministrator())
        //printf("You are an administrator\n");
        return 1;
    else
        //printf("You are not an administrator\n");
        return 0;
}

BOOL IsCurrentUserLocalAdministrator(void)
{
    BOOL   fReturn = FALSE;
    DWORD  dwStatus;
    DWORD  dwAccessMask;
    DWORD  dwAccessDesired;
    DWORD  dwACLSize;
    DWORD  dwStructureSize = sizeof(PRIVILEGE_SET);
    PACL   pACL = NULL;
    PSID   psidAdmin = NULL;

    HANDLE hToken = NULL;
    HANDLE hImpersonationToken = NULL;

    PRIVILEGE_SET   ps;
    GENERIC_MAPPING GenericMapping;

    PSECURITY_DESCRIPTOR     psdAdmin = NULL;
    SID_IDENTIFIER_AUTHORITY SystemSidAuthority = SECURITY_NT_AUTHORITY;

    const DWORD ACCESS_READ = 1;
    const DWORD ACCESS_WRITE = 2;

    __try {
        if (!OpenThreadToken(GetCurrentThread(), TOKEN_DUPLICATE | TOKEN_QUERY,
            TRUE, &hToken)) {
            if (GetLastError() != ERROR_NO_TOKEN)
                __leave;
            if (!OpenProcessToken(GetCurrentProcess(),
                TOKEN_DUPLICATE | TOKEN_QUERY, &hToken))
                __leave;
        }
        if (!DuplicateToken(hToken, SecurityImpersonation,
            &hImpersonationToken))
            __leave;

        if (!AllocateAndInitializeSid(&SystemSidAuthority, 2,
            SECURITY_BUILTIN_DOMAIN_RID,
            DOMAIN_ALIAS_RID_ADMINS,
            0, 0, 0, 0, 0, 0, &psidAdmin))
            __leave;

        psdAdmin = LocalAlloc(LPTR, SECURITY_DESCRIPTOR_MIN_LENGTH);
        if (psdAdmin == NULL)
            __leave;

        if (!InitializeSecurityDescriptor(psdAdmin,
            SECURITY_DESCRIPTOR_REVISION))
            __leave;
        // Compute size needed for the ACL.
        dwACLSize = sizeof(ACL) + sizeof(ACCESS_ALLOWED_ACE) +
            GetLengthSid(psidAdmin) - sizeof(DWORD);
        pACL = (PACL)LocalAlloc(LPTR, dwACLSize);
        if (pACL == NULL)
            __leave;
        if (!InitializeAcl(pACL, dwACLSize, ACL_REVISION2))
            __leave;
        dwAccessMask = ACCESS_READ | ACCESS_WRITE;
        if (!AddAccessAllowedAce(pACL, ACL_REVISION2, dwAccessMask,
            psidAdmin))
            __leave;

        if (!SetSecurityDescriptorDacl(psdAdmin, TRUE, pACL, FALSE))
            __leave;
        SetSecurityDescriptorGroup(psdAdmin, psidAdmin, FALSE);
        SetSecurityDescriptorOwner(psdAdmin, psidAdmin, FALSE);
        if (!IsValidSecurityDescriptor(psdAdmin))
            __leave;
        dwAccessDesired = ACCESS_READ;
        GenericMapping.GenericRead = ACCESS_READ;
        GenericMapping.GenericWrite = ACCESS_WRITE;
        GenericMapping.GenericExecute = 0;
        GenericMapping.GenericAll = ACCESS_READ | ACCESS_WRITE;

        if (!AccessCheck(psdAdmin, hImpersonationToken, dwAccessDesired,
            &GenericMapping, &ps, &dwStructureSize, &dwStatus,
            &fReturn)) {
            fReturn = FALSE;
            __leave;
        }
    } __finally {
        // Clean up.
        if (pACL) LocalFree(pACL);
        if (psdAdmin) LocalFree(psdAdmin);
        if (psidAdmin) FreeSid(psidAdmin);
        if (hImpersonationToken) CloseHandle(hImpersonationToken);
        if (hToken) CloseHandle(hToken);
    }

    return fReturn;
}
