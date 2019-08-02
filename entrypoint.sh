#!/bin/sh

#/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf &
#useradd -m -s /bin/bash $USER ; echo $USER:$USER | chpasswd

rm -rf /root/.ssh/*
mkdir -p /root/.ssh
ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""

/lib/systemd/systemd-udevd --debug &
udevadm trigger
startx

#mv /tmp/tempuser/.config /home/$USER/.config
#for i in $(ls /etc/skel) ; do cp -r $i /home/$USER/ ; done
#cp -r /etc/skel/. /home/$USER/
#cp -r /etc/skel/.config /home/$USER/
#HOME=/home/$USER

#chown -R $USER:$USER /home/$USER

#echo "rm -f /entrypoint.sh" >> run.sh
#echo "tail -f /dev/null" >> run.sh
#chmod +x run.sh
#sh run.sh
