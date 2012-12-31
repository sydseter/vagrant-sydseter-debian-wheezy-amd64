##Configuration done before packaging

### Upgrading the installation
    sudo su
    # uncomment the iso cd entry from sources.list, save and exit
    pico /etc/apt/sources.list

    # deb cdrom:[Debian GNU/Linux wheezy-DI-b4 _Wheezy_ - Official Snapshot amd64 CD Binary-1 20121117-20:31]/ wheezy main

    apt-get update
    apt-get upgrade

###Install sudo

    apt-get install sudo

    # add admin group and attach the vagrant user to the group
    visudo

    # Add this line, save and exit
    %admin	ALL=NOPASSWD: ALL

    groupadd admin
    usermod -G admin vagrant
    # Restart sudo
    /etc/init.d/sudo restart
    exit 
    exit
    # login with username vagrant and password vagrant and test sudo for vagrant
    sudo which sudo
    # should output: /usr/bin/sudo

###Install build-essentials

    sudo apt-get install linux-headers-$(uname -r) build-essential

    # restart the vm image

###Installing Guest Additions

    sudo apt-get install virtualbox-guest-utils

    # setup ~/vagrant-sydseter-debian-wheezy-amd64 as a shared folder with the name share the folder will be accessible from /media/sf_share for root

    # retart the vm image

###Install and configure ssh

    # Generate  ssh keys on the host machine (outside the vm image)

    mkdir -p ~/vagrant-sydseter-debian-wheezy-amd64/ssh
    chmod 700 ~/vagrant-sydseter-debian-wheezy-amd64/ssh
    cd ~/vagrant-sydseter-debian-wheezy-amd64/ssh
    ssh-keygen -t rsa -C "vagrant@vagrantup.com"

    # passphrase was left empty

    # on the vm image

    sudo apt-get install ssh

    mkdir home/vagrant/.ssh

    sudo cat /media/sf_share/ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys

    chown -R vagrant:vagrant /home/vagrant/.ssh

    cp /home/vagrant/.ssh/authorized_keys /home/vagrant/.ssh/id_rsa.pub

    chmod 0600 ~/.ssh/*

    chmod 0700 ~/.ssh

###Tweeks

    pico /etc/ssh/sshd_config

    # change UseDNS to no

###Reducing size

    sudo su
    
    # Boot into single user mode
    init 1

    # install toll for deleting empty space
    sudo apt-get install zerofree

    # make vm image read-only
    mount -o remount,ro /dev/sda1
    
    # delete empty space
    zerofree /dev/sda1

    # make vm image writeable
    mount -o remount,ro /dev/sda1

    sudo apt-get remove zerofree

    exit
    
    # login to the vm image again

    sudo su
    cd /media/sf_share/utils
    sh cleanup.sh
    exit


###Packaging box

    # shutdown vm image and remove shared folder

    # on the host machine

    cd ~/vagrant-sydseter-debian-wheezy-amd64

    vagrant init

    vim Vagrantfile

    # see to it that the ssh private key exist:
    # ~/vagrant-sydseter-debian-wheezy-amd64/ssh/id_rsa

    # Add this to the Vagrantfile
        require './utils/git_cloningservice.rb'
        # etc dir for abcn vagrant yaml configuration files
        git_etc = File.dirname(__FILE__) + '/utils/etc'

        # yaml configuration file suffix
        git_config_suffix = 'git'

        # Load the config
        git_cloning_service = Git::CloningService.new(
          git_etc,
          git_config_suffix)

        # Clone out the repositories if necessary
        git_cloning_service.clone

        # Get the location of the source folder where all the git repositories are stored
        # reuse this variable as a base for all shared vagrant folders
        git_src = git_cloning_service.src

        Vagrant::Config.run do |config|

            # Every Vagrant virtual environment requires a box to build off of.
            config.vm.box = 'vagrant-sydseter-debian-wheezy-amd64'
            config.ssh.username = 'vagrant'
            config.ssh.host = '127.0.0.1'

            # Private ssh key
            config.ssh.private_key_path = File.dirname(__FILE__) + '/ssh/id_rsa'
            
            # The url from where the 'config.vm.box' box will be fetched if it
            # doesn't already exist on the user's system.
            config.vm.box_url = "http://www.sydseter.com/vagrant/vagrant-sydseter-debian-wheezy-amd64.box"
        end

####Adding documentation

    mkdir -p ~/vagrant-sydseter-debian-wheezy-amd64/ssh/id_rsa/doc/images
    # copied the screen shots from the installation process
    # to ~/vagrant-sydseter-debian-wheezy-amd64-puppet/ssh/id_rsa/doc/images

#####Saving documentation
    # Ctrl-S as ~/vagrant-sydseter-debian-wheezy-amd64/ssh/id_rsa/doc/PACKAGING.md
    # Ctrl-S as ~/vagrant-sydseter-debian-wheezy-amd64/ssh/id_rsa/README.md

    vagrant package vagrant-sydseter-debian-wheezy-amd64 --base vagrant-sydseter-debian-wheezy-amd64 --output vagrant-sydseter-debian-wheezy-amd64.box --include doc,ssh

####Testing the box
    vagrant up
