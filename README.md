Lansmash SteamCache Dockers
=======================
A vagrant box to pull all the required docker containers for a lan
```
For a windows/osx machine, install vagrant then:
```
vagrant up
```
On a ubuntu machine you can manually run the shell provisioner commands that would be executed via the Vagrant file.

To send traffic via the steam cache, set your default gateway to the IP address of the Vagrant virtual machine.

The Vagrant virtual machine uses bridged networking so that it can talk directly to the network’s default gateway and doesn’t get caught up if you’ve changed the default gateway of the machine hosting the virtual machine.

This may not work when bridged to a wifi adapter...
