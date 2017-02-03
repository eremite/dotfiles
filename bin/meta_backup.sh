#!/bin/bash

# aws must be installed

filename=meta.$(date +"%Y.%m.%d").tar.gz
s3_bucket=daniel-devbox

# Backup
tar -C $META --exclude='**/tmp' -c -f - . | gzip > "$filename"
gpg -c "$filename"
aws s3 cp "${filename}.gpg" "s3://$s3_bucket/"

# Restore
cd
mkdir "meta"
cd "meta"
sudo chown -R dev:dev .
aws s3 cp "s3://$s3_bucket/${filename}.gpg" .
gpg -d "${filename}.gpg" > "$filename"
tar -xzf "$filename"
rm meta*
