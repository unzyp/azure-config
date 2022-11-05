#!/bin/bash
set -e

echo "Load latest repo"

sudo git clone https://unzyp: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@github.com/unzyp/moodleatma.git /var/www/html/moodle

echo "Connect azure storage account"

sudo mkdir /mnt/moodledata
if [ ! -d "/etc/smbcredentials" ]; then
sudo mkdir /etc/smbcredentials
fi
if [ ! -f "/etc/smbcredentials/moodledatabackup.cred" ]; then
    sudo bash -c 'echo "username=moodledatabackup" >> /etc/smbcredentials/moodledatabackup.cred'
    sudo bash -c 'echo "password=vDubONaER/4H0ckGO3Zrs4f4YOnAb9ji4slaOTzxB++HMhOxxQUY0LJZ+jouGpDGEKTsSPPdGHoo+AStcLf3HA==" >> /etc/smbcredentials/moodledatabackup.cred'
fi
sudo chmod 600 /etc/smbcredentials/moodledatabackup.cred

sudo bash -c 'echo "//moodledatabackup.file.core.windows.net/moodledata /mnt/moodledata cifs nofail,credentials=/etc/smbcredentials/moodledatabackup.cred,dir_mode=0777,file_mode=0777,serverino,nosharesock,actimeo=30" >> /etc/fstab'
sudo mount -t cifs //moodledatabackup.file.core.windows.net/moodledata /mnt/moodledata -o credentials=/etc/smbcredentials/moodledatabackup.cred,dir_mode=0777,file_mode=0777,serverino,nosharesock,actimeo=30

echo "Execute prepare VMSS script completed!"