#!/bin/sh

# some partitioning and mounting magick - commented for now as not adding addl storage
#/sbin/sfdisk /dev/vdd << EOF
#1,;
#EOF
#/sbin/mkfs -t ext4 /dev/vdd1
#/bin/mkdir /opt
#/bin/mount /dev/vdd1 /opt
#/bin/echo "/dev/vdd1    /opt    ext4    defaults    0  2" >> /etc/fstab

#
# apply fixes and install desktop and tigervnc
dnf -y upgrade
dnf -y group install "Workstation"
dnf -y install tigervnc-server

#
# install git
dnf -y install git

# vncsetup
# cp /lib/systemd/system/vncserver\@.service /etc/systemd/system/vncserver@.service
useradd -m dev
mkdir -p ~dev/.vnc
echo "Vncp8ss#" | vncpasswd -f > ~dev/.vnc/passwd
chmod 600 ~dev/.vnc/passwd
echo "geometry=1680x1050" > ~dev/.vnc/config
echo "localhost" >> ~dev/.vnc/config
chown -R dev.dev ~dev/.vnc
cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@.service
sed -i.bak 's/<USER>/dev/' /etc/systemd/system/vncserver@.service && rm -f /etc/systemd/system/vncserver@.service.bak
systemctl daemon-reload
systemctl start vncserver@:5.service
systemctl enable vncserver@:5.service
cat > /etc/sudoers.d/dev <<-EOF
## let dev do whatever
dev	ALL=(ALL)	NOPASSWD: ALL
EOF

# maven (CentOS includes OpenJDK 8)
dnf -y install maven

# nodejs
dnf -y module enable nodejs:12
dnf -y install nodejs

# install ibm developer cli
curl -sL https://ibm.biz/idt-installer | bash

# install oc
curl -LsO https://mirror.openshift.com/pub/openshift-v4/clients/oc/4.4/linux/oc.tar.gz
tar -xf oc.tar.gz
mv oc /usr/local/bin/oc
rm -rf oc.tar.gz

# touch done file in /root
touch /root/cloudinit.done


