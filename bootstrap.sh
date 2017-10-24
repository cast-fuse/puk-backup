#!/bin/bash

# script to run when EC2 instance first boots
# add this when provisioning EC2 instance

# downloads and links heroku toolbelt
curl -O https://cli-assets.heroku.com/heroku-cli/channels/stable/heroku-cli-linux-x64.tar.gz
tar -xvzf heroku-cli-linux-x64.tar.gz
mkdir -p /usr/local/lib /usr/local/bin
mv heroku-cli-v6.14.36-15f8a25-linux-x64 /usr/local/lib/heroku
ln -s /usr/local/lib/heroku/bin/heroku /usr/local/bin/heroku
rm -rf heroku-cli-linux-x64.tar.gz

# syncs backup scripts folder to instance
cd /home/ec2-user
aws s3 sync s3://parkinsons-and-me-db-backups/backup-scripts ./backup-scripts

# moves .netrc heroku login info to correct location
mv "./backup-scripts/.netrc" "./"

# allows backup script to be executed
sudo chmod +x "./backup-scripts/backup.sh"

# adds cron job task (executes backup.sh early every morning)
crontab -a ./backup-scripts/puk-cron
