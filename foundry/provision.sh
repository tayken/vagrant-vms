#! /bin/bash
set -eu

wget -O foundryvtt.zip ${1}
apt update
apt install -y libssl-dev unzip
curl -sL https://deb.nodesource.com/setup_22.x | bash -
apt install -y nodejs
npm install pm2 -g
sudo -u vagrant mkdir /home/vagrant/foundryvtt
sudo -u vagrant unzip foundryvtt.zip -d /home/vagrant/foundryvtt
sudo -u vagrant pm2 start "node /home/vagrant/foundryvtt/main.js --dataPath=/home/vagrant/foundrydata" --name foundry
sudo -u vagrant pm2 save
env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u vagrant --hp /home/vagrant
rm foundryvtt.zip
chsh -s /bin/bash vagrant
