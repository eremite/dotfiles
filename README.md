## Installation

`bin/devbox_install.sh` will boostrap a new Amazon Linux instance.

### Back up meta from devbox

```sh
cd /data
filename=meta.$(date +"%F").tar.gz
tar -C $META --exclude='**/tmp' -c -f - . | gzip > $filename
gpg -c $filename
docker run --rm -it --volumes-from data -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY anigeo/awscli s3 cp /data/$filename.gpg s3://daniel-devbox/$filename.gpg --acl bucket-owner-full-control
rm $filename*
```

### Restore meta directory

```sh
filename=meta.$(date +"%F").tar.gz
mkdir -p data/meta
cd data/meta
docker run --rm -it -v $(pwd):/tt -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY anigeo/awscli s3 cp s3://daniel-devbox/$filename.gpg /tt/$filename.gpg
gpg -d $filename.gpg > $filename
tar -zxf $filename
```
