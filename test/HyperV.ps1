#Requires -Version 5.0
##Requires -RunAsAdministrator
#************** the two first lines are like pragma in C/C++
#************** i comment the second because error is not trapped by the script

# SITE: / https://docs.microsoft.com/en-us/powershell/module/hyper-v/add-vmdvddrive?view=win10-ps

#
# Version 1 : 30 january 2019
#
#
# Put the new ISO file built with WimBuilder in the DVD on a hyperv VM
#
# the VM is created
# the VM is not running ( the script can stop the VM but i think it's dangerous for the user if he makes some work on the old iso )
# if vmconnect.exe is running, it can runs the target VM or an other VM
# if vmconnect.exe is running, it can wait for starting this VM : change iso is possible if the VM is not running
# in this last cas, we need to give focus to vmconnect.exe, not to launch an other instance of vmconnect

param ([string] $VmName = "TestIso" )

#parameters from UI : $VmName       "TestIso" = default value for my test

# use environment variable of WimBuilder
if( $env:WB_ROOT -eq $null){
    # error : $env:WB_ROOT not found
    write-host -ForegroundColor Red "error : WB_ROOT not found"
    # for my tests...
    #$VMISOFile="C:\Users\noelBlanc\Documents\MicroWinpeBuilder-1809-en\winpe10V1809.ISO"
    #$VMISOFile="C:\Users\noelBlanc\Documents\wb\Win10XPE\Win10XPE_x64.ISO"
    break
}else{
    $VMISOFile=join-path $env:WB_ROOT "_Factory_\BOOTPE.iso"
}

if (-not (test-path $VMISOFile)){
    # error : $VMISOFile not found
    write-host -ForegroundColor Red "error : $VMISOFile not found"
    break
}

#variables
$ErrorActionPreference = "stop"                     # for try/catch
$ComputerName = $env:computername
$process = "VmConnect.exe"                          # vmconnect.exe is always in system32. If not, something is wrong in windows10
$VmConnect = join-path $env:SystemRoot "system32\$process"
$launchFlag = $true                                 # launch or focus vmconnect

#test admin
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = new-object Security.Principal.WindowsPrincipal $identity
if ( ! $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) ){
    # error : need an admin
    write-host -ForegroundColor Red "error : needs administrator rights"
    break
}

#test presence of vmconnect.exe = hyperv
if ( -not (test-path $VmConnect) ){
    # error : vmconnect.exe not found
    write-host -ForegroundColor Red "error : vmconnect.exe not found"
    break
}

#test presence module hyperv for PS
try{
	if ( -not $(get-module hyper-v) ){
		import-module  hyper-v
	}
}
catch{
    # error : module hyper-v not found
    write-host -ForegroundColor Red "error : module hyper-v not found"
    break
}

# test if VM exists and is running : need to be stopped
write-host -ForegroundColor Cyan "Get-VM -VMName $VmName"
try{
    if ( (Get-VM -VMName $VmName).State -ilike "Running" ){
        # Get-VM -VMName $VmName | stop-vm   #can be dangerous for the user if he doesn't want to lost something
        # error : one or more VM is/are Running
        write-host -ForegroundColor Red "error : one or more VM is/are Running"
        break
    }
}
catch{
    write-host -ForegroundColor Red "error : Vm $VmName not found"
    break
}

#
# test if one or more instances of vmconnect.exe is running. 
# If yes, analyze each command line :
#	If vmconnect.exe launched the vm and it is waiting to "start" the VM, only focus, don't launch an other instance
#   But only one vmconnect must be waiting with this VMname. If more, we can't focus the good vmconnect
#       And change is dangerous
$objVmConnect = Get-WmiObject Win32_Process -Filter "name = '$process'" | Select-Object CommandLine,ProcessId

$PidVmconnect=$null
$i=0
$objVmConnect | ?{ ($_.CommandLine -split " ")[2] -ilike "*$VmName*"} | %{$i++; $PidVmconnect=$_.ProcessId; $launchFlag = $false}
if ($i -gt 1){
    # error : more than one instance of vmconnect launched $VmName : we can't find the good one
    write-host -ForegroundColor Red "error : more than one instance of vmconnect launched $VmName : we can't find the good one"
    break
}
#find MainWindowHandle for focus
$MainWindowHandle=$null
if ($i -eq 1){
    $MainWindowHandle=([System.Diagnostics.Process]::GetProcessById($PidVmconnect)).MainWindowHandle
}

#
# Modify the ISO file in the VM
#
write-host -ForegroundColor Cyan "Set ISO file in the $VmName ..."
try{
    # if DVD is present in vm, create one
    if (-not $(Get-VM -VMName $VmName | Get-VMDVDDrive) ){
	    Get-VM -VMName $VmName | Add-VMDvdDrive
        start-sleep -s 1 
    }
    # change ISO
    write-host -ForegroundColor Cyan "Adding the new ISO $VMISOFile ..."
    Get-VM -VMName $VmName | Get-VMDVDDrive | Set-VMDVDDrive -Path "$VMISOFile"
}

catch{
    #error when adding the iso
    write-host -ForegroundColor Red "error : adding the iso failed"
    break
}

#
# some preparation for set focus to vmconnect
#

Add-Type -TypeDefinition @"
   public enum ShowWindowEnum
   {
    Hide = 0,
    ShowNormal = 1,
    ShowMinimized = 2,
    ShowMaximized = 3,
    Maximize = 3,
    ShowNormalNoActivate = 4,
    Show = 5,
    Minimize = 6,
    ShowMinNoActivate = 7,
    ShowNoActivate = 8,
    Restore = 9,
    ShowDefault = 10,
    ForceMinimized = 11
   }
"@

if (-not ("NsWindow.Window" -as [Type]))
{
    Add-Type -Name Window -Namespace NsWindow -MemberDefinition ' 
        [DllImport("user32.dll")]
        public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);

        [DllImport("user32.dll")]
        public static extern bool SetForegroundWindow(IntPtr hWnd);
    '
}

#
# launch or focus vmconnect
#
if ( $MainWindowHandle){
	#set focus to the good one
    # $GoodVmconnect = pid of vmconnect to set "focus"
	[NsWindow.Window]::ShowWindow($MainWindowHandle,[ShowWindowEnum]::ShowNormalNoActivate);
    [NsWindow.Window]::SetForegroundWindow($MainWindowHandle);
}else{
    # launch vmconnect
	& $VmConnect $ComputerName  $VmName -C "0"
}
# clic start in vmconnect
#the end