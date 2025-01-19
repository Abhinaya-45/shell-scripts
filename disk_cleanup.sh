#!/bin/bash

# Configuration
SOURCE_DIR="/path/to/your/folder" # Replace with your directory path
CONTAINER_NAME="<your-container-name>" # Azure Blob container name
STORAGE_ACCOUNT="<your-storage-account>" # Azure Storage account name
STORAGE_KEY="<your-storage-account-key>" # Azure Storage account key

# Number of days
OLDER_THAN=30

# Export storage account key
export AZURE_STORAGE_ACCOUNT=$STORAGE_ACCOUNT
export AZURE_STORAGE_KEY=$STORAGE_KEY

# Find and move files older than 30 days
find $SOURCE_DIR -type f -mtime +$OLDER_THAN -print | while read FILE; do
    RELATIVE_PATH=${FILE#$SOURCE_DIR/} # Get relative path
    DESTINATION="$CONTAINER_NAME/$(dirname $RELATIVE_PATH)" # Destination directory in blob storage

    # Create destination directory in blob storage if it does not exist
    az storage blob directory create --account-name $STORAGE_ACCOUNT --account-key $STORAGE_KEY --container-name $CONTAINER_NAME --name $(dirname $RELATIVE_PATH)

    # Upload the file to Azure Blob Storage
    az storage blob upload --file "$FILE" --container-name "$CONTAINER_NAME" --name "$RELATIVE_PATH"

    if [ $? -eq 0 ]; then
        echo "Successfully uploaded $FILE to Azure Blob Storage."
        
        # Remove the file from the local system
        rm "$FILE"
        echo "Deleted $FILE from $SOURCE_DIR."
    else
        echo "Failed to upload $FILE to Azure Blob Storage."
    fi
done
