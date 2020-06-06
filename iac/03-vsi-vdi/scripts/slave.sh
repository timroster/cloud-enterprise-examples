#!/bin/sh

# some partitioning and mounting magick - commented for now as not adding addl storage
#/sbin/sfdisk /dev/vdb << EOF
#1,;
#EOF
#/sbin/mkfs -t ext4 /dev/vdb1
#/bin/mkdir /opt
#/bin/mount /dev/vdb1 /opt
#/bin/echo "/dev/vdb1    /opt    ext4    defaults    0  2" >> /etc/fstab

#
# apply fixes and install desktop and tigervnc
yum update -y
yum -y groupinstall "GNOME Desktop"
yum -y install tigervnc-server

#
# update git
sudo yum -y install https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm
sudo yum -y install git

# vncsetup
cp /lib/systemd/system/vncserver\@.service /etc/systemd/system/vncserver@:1.service
useradd -m dev
mkdir -p ~dev/.vnc
echo "Vncp8ss#" | vncpasswd -f > ~dev/.vnc/passwd
chmod 600 ~dev/.vnc/passwd
echo "geometry=1920x1080" > ~dev/.vnc/config
echo "localhost" >> ~dev/.vnc/config
chown -R dev.dev ~dev/.vnc
cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:5.service
sed -i.bak 's/<USER>/dev/' /etc/systemd/system/vncserver@:5.service && rm -f /etc/systemd/system/vncserver@:5.service.bak
systemctl daemon-reload
systemctl start vncserver@:5.service
systemctl enable vncserver@:5.service
cat > /etc/sudoers.d/dev <<-EOF
## let dev do whatever
dev	ALL=(ALL)	NOPASSWD: ALL
EOF

# maven (CentOS includes OpenJDK 8)
yum -y install maven

# nodejs
yum -y install gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_12.x | sudo -E bash -
yum install -y nodejs

# install ibm developer cli
curl -sL https://ibm.biz/idt-installer | bash

# install oc
curl -LsO https://mirror.openshift.com/pub/openshift-v4/clients/oc/4.3.18-202005011805.git.1.4fda572.el7/linux/oc.tar.gz
tar -xf oc.tar.gz
mv oc /usr/local/bin/oc
rm -rf oc.tar.gz

# touch done file in /root
touch /root/cloudinit.done


