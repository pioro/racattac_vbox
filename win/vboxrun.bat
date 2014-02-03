rem create VM config
VBoxManage createvm --name collabn1 --ostype Oracle_64 --register --basefolder c:\vm\racattac\
VBoxManage modifyvm collabn1 --memory 3072
VBoxManage createhd --filename c:\vm\racattac\\collabn1\collabn1.vdi --size 30720 --format VDI --variant Standard
VBoxManage modifyvm collabn1 --usb on
VBoxManage storagectl collabn1 --name SATA --add sata --portcount 8 --controller IntelAHCI 
VBoxManage storageattach collabn1 --storagectl SATA --port 1 --type hdd --medium c:\vm\racattac\\collabn1\collabn1.vdi
VBoxManage storagectl collabn1 --name IDE --add ide --controller PIIX4 --hostiocache on --bootable on
rem attach ISO with OS
VBoxManage storageattach collabn1 --storagectl IDE --port 1 --device 0 --type dvddrive --medium "C:\Downloads\V37084-01.iso"
rem Add network configuration to VM
VBoxManage modifyvm collabn1 --nic1 hostonly --hostonlyadapter1 "VirtualBox Host-Only Ethernet Adapter" --nictype1 Am79C973
VBoxManage modifyvm collabn1 --nic2 intnet --intnet2 rac-priv --nictype2 Am79C973
VBoxManage modifyvm collabn1 --nic3 nat --nictype3 Am79C973
rem Add shared folder 
VBoxManage sharedfolder add collabn1 --name 12cR1 --hostpath "C:\Downloads" --automount
rem Add floppy for KS
rem VBoxManage storagectl collabn1 --name Floppy --add floppy
rem VBoxManage storageattach collabn1 --storagectl Floppy --type fdd --device 0 --medium C:\vm\myimage.vfd
rem Set booting device
VBoxManage modifyvm  collabn1 --boot1 disk
rem Add shared ASM storage
VBoxManage createhd --filename c:\vm\racattac\asm1.vdi --size 5120 --format VDI --variant Fixed
VBoxManage modifyhd c:\vm\racattac\asm1.vdi --type shareable
VBoxManage storageattach collabn1 --storagectl SATA --port 2 --type hdd --medium c:\vm\racattac\asm1.vdi
VBoxManage createhd --filename c:\vm\racattac\asm2.vdi --size 5120 --format VDI --variant Fixed
VBoxManage modifyhd c:\vm\racattac\asm2.vdi --type shareable
VBoxManage storageattach collabn1 --storagectl SATA --port 3 --type hdd --medium c:\vm\racattac\asm2.vdi
VBoxManage createhd --filename c:\vm\racattac\asm3.vdi --size 5120 --format VDI --variant Fixed
VBoxManage modifyhd c:\vm\racattac\asm3.vdi --type shareable
VBoxManage storageattach collabn1 --storagectl SATA --port 4 --type hdd --medium c:\vm\racattac\asm3.vdi
