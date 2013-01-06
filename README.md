## vagrant-sydseter-debian-wheezy-amd64

Vagrant virtualbox configuration for debian wheezy amd64 arch.
Minimal provisioning for debian wheezy environments

###Author
[Johan Sydseter](http://www.sydseter.com)
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
libtest-bdd-cucumber-perl 0.11-1<br>
###Installation process
is documented in [images](vagrant-sydseter-debian-wheezy-amd64/blob/master/doc/images)
###Configuration done before packaging
See: [the packaging documentation](vagrant-sydseter-debian-wheezy-amd64/blob/master/doc/README.md) page for details 
###Security

username: vagrant
password: vagrant

###Installing the vagrant box

If you are running Mac OS or Windows, please install both vagrant and virtualbox.
Then from the root of this repository, start the environment from the 
command line with 'vagrant up'.

####Debian/Ubuntu linux
    sudo apt-get install virtualbox
    sudo apt-get install vagrant
    # From the root of this repository, do the following from the cmd.
    vagrant up
###Post configuration
You can configure the Vagrant file to clone out your git repositories before the
box boots. see [the git service config](vagrant-sydseter-debian-wheezy-amd64/blob/master/etc/git.yml) for details.
