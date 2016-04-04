#!/bin/bash

# Install awscli with apt-get
# sudo apt-get -y install python
# curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
# sudo python get-pip.py
# sudo pip install awscli

export AWS_ACCESS_KEY_ID=EXAMPLE
export AWS_SECRET_ACCESS_KEY=EXAMPLE

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
