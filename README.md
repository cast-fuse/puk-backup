# PUK Backup

disaster recovery service for "Parkinson's and me" data

### What?

+ A simple service that archives database snapshots from the "Parkinson's and me" database to Amazon S3
+ Downloads the latest database snapshot early every morning and archives it to S3
+ Runs on an Amazon EC2 instance (t2.nano)

### Why?

Provides a last line of defence for data loss incase we ever lose the data stored in heroku backups

### How it works

+ the `bootstrap.sh` script is run when the instance first boots
+ the `backup.sh` script is run on a cron job every morning at 2.10
