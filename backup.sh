#!/bin/bash

# Configuration
SOURCE_DIRECTORIES="/etc /var/www /home /"
BACKUP_DIR="/backups"
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
REMOTE_NFS_DIR="nfs_server:/remote/backups"

# Ensure backup directory exists
mkdir -p $BACKUP_DIR

# Perform backup
echo "Starting backup..."
tar -czvf $BACKUP_FILE $SOURCE_DIRECTORIES

# Sending it to remote NFS

rsync -avz $BACKUP_DIR/ $REMOTE_NFS_DIR

if [ $? -eq 0 ]; then
    echo "Backup completed successfully. Backup file: $BACKUP_FILE"
else
    echo "Backup failed."
    exit 1
fi
