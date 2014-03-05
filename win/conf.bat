rem @echo off

rem your settings
set ORACLEISOPATH=C:\Downloads\V37084-01.iso
set DOWNLOADFOLDER=C:\Downloads
set VBDIR=C:\Program Files\Oracle\VirtualBox
set VMFOLDER=c:\vm\racattac\



rem RACAttack settings - do not change it 

set COLLABN1VDI=%VMFOLDER%\collabn1\
set COLLABN2VDI=%VMFOLDER%\collabn2\
set HOSTONLYNETNAME="VirtualBox Host-Only Ethernet Adapter"

set HOSTIP=192.168.78.1
set DHCPIP=192.168.78.2
set LOWIP=192.168.78.100
set HIGHIP=192.168.78.254