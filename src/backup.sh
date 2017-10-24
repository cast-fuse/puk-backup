#!/bin/bash

FILE_NAME="$(date '+%Y-%m-%d-%H:%M:%S')-puk-backup"

# fetches most recent db snapshot url from heroku
BACKUP_URL=`/usr/local/bin/heroku pg:backups:url --app parkinsons-and-me`

# downloads db file and gzips it
mkdir -p "/home/ec2-user/tmp/backups"
curl $BACKUP_URL | gzip -c > "/home/ec2-user/tmp/backups/$FILE_NAME.gz"

# uploads the db file to s3
aws s3 cp "/home/ec2-user/tmp/backups/$FILE_NAME.gz" s3://parkinsons-and-me-db-backups

# cleanup
rm -rf "/home/ec2-user/tmp"

echo "complete"
