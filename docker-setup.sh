#for aufs storage
apt-get update
apt-get -y install linux-image-extra-$(uname -r) wget

#docker install
wget -qO- https://get.docker.com/ | sh

#docker test
docker run hello-world

#optional step, add user access to docker daemon
usermod -aG docker ubuntu
