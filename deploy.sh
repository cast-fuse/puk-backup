#!/bin/zsh

echo "uploading scripts to s3"
aws s3 sync "./src/" "s3://parkinsons-and-me-db-backups/backup-scripts"
echo "sync complete"
