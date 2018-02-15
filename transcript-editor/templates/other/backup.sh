#!/bin/bash

AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY=$AWS_ACCESS_KEY
BUCKET=transcript-editor

PG_USER=postgres
PG_PASSWORD=$DB_PASS
PG_HOST=localhost

pg_dump -U $PG_USER \
        -h $PG_HOST -Fc \
        --file=backup.custom transcript_editor_production

S3_KEY=$BUCKET/backups/$(date "+%Y-%m-%d")-backup.custom
aws s3 cp backup.custom s3://$S3_KEY --sse AES256

rm -f backup.custom
