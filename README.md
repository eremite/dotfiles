## Installation

Use [rcm](https://github.com/thoughtbot/rcm)

## Notes on using the devbox

### Build the Dockerfile

```bash
docker build --force-rm -t eremite/devbox .
```

### Initialize Docker data containers

```bash
# docker run -v /data --name data busybox true # old way
docker run -v /data --name=data eremite/devbox sudo chown -R dev:dev /data
```

### Back up meta from devbox

```sh
cd /data
filename=meta.$(date +"%F").tar.gz
tar -C /data/meta --exclude='**/tmp' -c -f - . | gzip > $filename
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

### Update devbox runner script

```bash
curl -L https://raw.githubusercontent.com/eremite/dotfiles/master/devbox > devbox
```

### Run the devbox!

```bash
docker run -it --rm --name=devbox --volumes-from=data -v /var/run/docker.sock:/var/run/docker.sock eremite/devbox /bin/bash --login
```

### Set up a devbox on a new Amazon Linux instance

```bash
sudo yum update
sudo yum install -y docker
sudo service docker start
curl -L https://raw.githubusercontent.com/eremite/dotfiles/master/devbox > devbox
echo '. ./bashrc_devbox_host' >> .bashrc
mkdir $HOME/data
source devbox
```
