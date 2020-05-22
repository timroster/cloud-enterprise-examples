#!/bin/sh
# some partitioning and mounting magick
#!/bin/sh
/sbin/sfdisk /dev/xvdc << EOF
1,;
EOF
/sbin/mkfs -t ext4 /dev/xvdc1
/bin/mkdir /opt
/bin/mount /dev/xvdc1 /opt
/bin/echo "/dev/xvdc1    /opt    ext4    defaults    0  2" >> /etc/fstab

#
# apply fixes
apt-get update
apt-get upgrade -y

#
# update git
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt-get update
sudo apt-get install -y git

# maven / java
apt-get install -y openjdk-8-jdk maven

# nodejs
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

# install yq 
sudo add-apt-repository -y ppa:rmescandon/yq
sudo apt-get update
sudo apt-get install -y --allow-unauthenticated yq

# install ibm developer cli
curl -sL https://ibm.biz/idt-installer | bash

# install oc
curl -LsO https://mirror.openshift.com/pub/openshift-v4/clients/oc/4.3.18-202005011805.git.1.4fda572.el7/linux/oc.tar.gz
tar -xf oc.tar.gz
mv oc /usr/local/bin/oc
rm -rf oc.tar.gz

# restart system to allow applied interface security groups to take effect
shutdown -r now

