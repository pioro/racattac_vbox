@echo off
call conf.bat

rem VB dir exist 
dir /d "%VBDIR%" > nul 2>nul
if %ERRORLEVEL% GTR 0 goto NOPATH

set PATH="%VBDIR%";%PATH%

rem check if host interface exist if yes check IP
ipconfig | find /I /C "VirtualBox Host-Only Network" > null
if %ERRORLEVEL% == 0 goto VBNETEXIST

rem Creating network 
VBoxManage hostonlyif create ipconfig "VirtualBox Host-Only Ethernet Adapter"  --ip %HOSTIP% --netmask 255.255.255.0
VBoxManage dhcpserver add --ifname "VirtualBox Host-Only Ethernet Adapter" --ip %DHCPIP% --netmask 255.255.255.0 --lowerip %LOWIP% --upperip %HIGHIP% --enable

:AFTERNETWORKCHECK
rem @echo off
rem create VM folder
mkdir "%VMFOLDER%" 2>nul
echo Generating script
del vboxrun.bat

for /F "delims=;" %%A in (../vb.vboxs) do call replace_line.bat "%%A"

echo Script generated. Press Enter to create a VirtualBox configuration
pause 0
call vboxrun.bat


rem END OF MAIN PROGRAM
goto :END

rem NO PATH
:NOPATH
echo VirtualBox directory - %VBDIR% - not found 
echo check conf.bat file
goto END

rem VB host only network exist
:VBNETEXIST
echo VirtualBox Host-Only network already exist
echo Checking IP
ipconfig | find /I /C "%HOSTIP%" > nul
if %ERRORLEVEL% GTR 0 goto WRONGIP
echo Your host-only IP is correct for RACAttack
goto AFTERNETWORKCHECK

:WRONGIP
echo VirtualBox Host-Only network exist but it has a wrong IP address
echo Exiting

goto END
:END