#!/bin/sh

/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf &
useradd -m -s /bin/bash $USER ; echo $USER:$USER | chpasswd

rm -rf /home/$USER/.ssh/*
mkdir -p /home/$USER/.ssh
ssh-keygen -b 2048 -t rsa -f /home/$USER/.ssh/id_rsa -q -N ""
curl -X POST app-provider/key -H 'content-type: application/json' -d '{"key":"'$(sed -E 's/ /%20/g' /home/$USER/.ssh/id_rsa.pub)'","user":"'$USER'"}'

mv /tmp/tempuser/.config /home/$USER/.config
cp /etc/skel/.* /home/$USER/
HOME=/home/$USER

chown -R $USER:$USER /home/$USER
tail -f /dev/null
