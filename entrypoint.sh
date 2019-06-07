#!/bin/sh

# make app-provider work
rm -rf /home/$USER/.ssh/*
mkdir -p /home/$USER/.ssh
ssh-keygen -b 2048 -t rsa -f /home/$USER/.ssh/id_rsa -q -N ""
curl -X POST app-provider/key -H 'content-type: application/json' -d '{"key":"'$(sed -E 's/ /%20/g' /home/$USER/.ssh/id_rsa.pub)'","user":"'$USER'"}'

mv /tmp/tempuser/.config /home/$USER/.config

HOME=/home/$USER

chown -R $USER:$USER /home/$USER

useradd -m -s /bin/bash $USER ; echo $USER:$USER | chpasswd
cp /etc/skel/.* /home/$USER/

chown -R $USER:$USER /home/$USER

echo "rm -f /entrypoint.sh" > /run.sh
echo "/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf" >> /run.sh
chmod +x /run.sh
sh /run.sh