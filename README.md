## vagrant-sydseter-debian-wheezy-amd64

Startsiden Vagrant virtualbox package for debian wheezy amd64 arch.
Minimal provisioning for debian wheezy environments

###Author
Johan Sydseter <johan.sydseter@startsiden.no>
###OS
Debian-Linux
###Arch
amd64
###ISO image
[debian.org](http://cdimage.debian.org/cdimage/wheezy_di_beta4/amd64/iso-cd/debian-wheezy-DI-b4-amd64-CD-1.iso "Debian-Wheezy amd64 ISO image")
###ISO image - build date:
17-Nov-2012 22:05
###Vagrant packaging Guidlines
[vagrantup.com](http://vagrantup.com/v1/docs/base_boxes.html "Vagrant packaging guidelines")
###Installed packages
sudo 1.8.5p2-1<br>
linux-headers-3.2.0-4-amd64<br>
build-essential 11.5<br>
virtualbox-guest-utils 4.1.18-dfsg-1.1<br>
ssh 1:6.0p1-3
###Installation process
is documented in images in the same folder as this README.md file
After the installation process ends, unmount the debian ISO image.
###Configuration done before packaging
See: [the packaging documentation](vagrant-sydseter-debian-wheezy-amd64/blob/master/doc/README.md) page for details 
###Installing the vagrant box
    # From the root of this repository, do the following from the cmd.
    vagrant up
