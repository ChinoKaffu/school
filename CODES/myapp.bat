@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

goto menu
:menu
cls
title  KaffuChino Privacy Tool
mode 76, 42

FOR /F "skip=2 tokens=2,3" %%A IN ('reg.exe query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{ae0bf5b3-bc16-459a-9b5f-065aed6fcd5f}" /v "NameServer"') DO set "DFMT=%%B"
FOR /f "tokens=1 delims=," %%a in ("%DFMT%") do set primDNS=%%a
FOR /f "tokens=2 delims=," %%a in ("%DFMT%") do set secDNS=%%a
FOR /F "skip=2 tokens=2,3" %%A IN ('reg.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value"') DO set "micval=%%B"
FOR /F "skip=2 tokens=2,3" %%A IN ('reg.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v "Value"') DO set "camval=%%B"

set msg=AT RISK
if %micval%==Deny if %camval%==Deny if %primDNS%==88.198.70.38 if %secDNS%==1.1.1.1 (set msg=SAFE)



echo:
echo:       Welcome, %USERNAME%
echo:       ______________________________________________________________
echo:                               CONTEXT MENU
echo:                                  =Main=
echo:               Class Modes
echo:             [1] Enable "Class mode"
echo:             [2] Revert to safe private mode
echo:             __________________________________________________   
echo:
echo:               DNS Server
echo:             [3] Use 88.198.70.38 as main DNS server (hosts based)
echo:             [4] Use 1.1.1.1 as main DNS server (safe-ish?)
echo:             __________________________________________________   
echo:
echo:               Mic Privacy
echo:             [5] Disallow use of mic in privacy settings
echo:             [6] Allow use of mic in privacy settings
echo:             __________________________________________________   
echo:
echo:               Camera Privacy
echo:             [7] Disallow use of camera in privacy settings
echo:             [8] Allow use of camera in privacy settings           
echo:             __________________________________________________   
echo:
echo:             [9] MORE
echo:                         
echo:                             CURRENT STATUS
echo: 	        Primary DNS Server:          "%primDNS%"
echo: 	        Secondary DNS Server:        "%secDNS%"
echo:           
echo: 	        App access to microphone is: "%micval%"
echo: 	        App access to webcam is:     "%camval%"
echo:    
echo:                           You are currently %msg%!
echo:       ______________________________________________________________
echo:
echo:                   "Enter a menu option in the Keyboard"
echo:
echo:

choice /C 123456789y /N
set _erl=%errorlevel%
if %_erl%==9 goto moremenu
if %_erl%==8 goto unprivcam
if %_erl%==7 goto privcam
if %_erl%==6 goto unprivmic
if %_erl%==5 goto privmic
if %_erl%==4 goto dnsnotsafe
if %_erl%==3 goto dnssafe
if %_erl%==2 (
netsh interface ip set dns name="Ethernet" static 88.198.70.38
netsh interface ip add dns name="Ethernet" addr=1.1.1.1 index=2
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone /t REG_SZ /v Value /d Deny /f
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam /t REG_SZ /v Value /d Deny /f
)
if %_erl%==1 (
netsh interface ip set dns name="Ethernet" static 1.1.1.1
netsh interface ip add dns name="Ethernet" addr=9.9.9.9 index=2
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone /t REG_SZ /v Value /d Allow /f
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam /t REG_SZ /v Value /d Allow /f
)

goto menu

:moremenu
cls
title  KaffuChino Multitool
mode 76, 26
echo:
echo:       ______________________________________________________________
echo:
echo:                               CONTEXT MENU 
echo:                                 =Page 2=
echo:               More Tools
echo:             [1] Launch ipconfig/all
echo:             [2] Launch ipconfig/flushdns
echo:             [3] Open Privacy settings:Microphone
echo:             [4] Open Privacy settings:Webcam
echo:             [5] Perform basic system scan
echo:             __________________________________________________  
echo:
echo:             [9] BACK
echo:
echo:       ______________________________________________________________
echo:
echo:                  "Enter a menu option in the Keyboard"
choice /C 1234567890 /N 
set _erl=%errorlevel%

if %_erl%==1 goto openipconfig
if %_erl%==2 goto flush
if %_erl%==3 start ms-settings:privacy-microphone
if %_erl%==4 start ms-settings:privacy-webcam
if %_erl%==5 goto basicscan
if %_erl%==9 goto menu
goto moremenu

:flush
start cmd.exe @cmd /k "ipconfig /flushdns & pause>nul & exit"
goto menu

:dnssafe
netsh interface ip set dns name="Ethernet" static 88.198.70.38
netsh interface ip add dns name="Ethernet" addr=1.1.1.1 index=2
goto menu

:dnsnotsafe
netsh interface ip set dns name="Ethernet" static 1.1.1.1
netsh interface ip add dns name="Ethernet" addr=9.9.9.9 index=2
goto menu

:privmic
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone /t REG_SZ /v Value /d Deny /f
goto menu

:unprivmic
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone /t REG_SZ /v Value /d Allow /f
goto menu

:privcam
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam /t REG_SZ /v Value /d Deny /f
goto menu

:unprivcam
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam /t REG_SZ /v Value /d Allow /f
goto menu

:openipconfig
start cmd.exe @cmd /k "ipconfig/all & pause>nul & exit"
goto menu

:basicscan
start cmd.exe @cmd /k "DISM.exe /Online /Cleanup-image /Restorehealth & sfc /scannow & pause>nul & exit"
goto menu
