# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/xenial64"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network "public_network", use_dhcp_assigned_default_route: true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
     # Customize the amount of memory on the VM:
     vb.memory = "4096"
  end

  # fix hosts ubuntu/xenial
  config.vm.provision "shell", inline: <<-EOC
    echo 127.0.0.1 `hostname` | tee -a /etc/hosts
  EOC
  
  #change password for default user ubuntu 
  # (Windows putty has trouble finding key, this is an insecure work around)
  config.vm.provision "shell", inline: "echo \
	ubuntu:vbepyu7MkHQ8woKxhEnQFtL | chpasswd"
 
  #run docker setup commands
  config.vm.provision "shell", path: "docker-setup.sh"

  #set timezone
  config.vm.provision "shell", inline: "
  	ln -fs /usr/share/zoneinfo/Australia/Brisbane /etc/localtime;
  	dpkg-reconfigure --frontend noninteractive tzdata "

  #pull docker containers
  config.vm.provision "shell", path: "docker-containers.sh"

end
