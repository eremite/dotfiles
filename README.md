## Installation

Use [rcm](https://github.com/thoughtbot/rcm)

## Notes on using the devbox

### Build the Dockerfile

```bash
docker build --force-rm -t eremite/devbox .
```

### Create a data container

```bash
docker run -v /data --name data busybox true # old way
docker run -v /data --name=data eremite/devbox sudo chown -R dev:dev /data
```

### Back up meta

```bash
docker run --rm --volumes-from data -v $(pwd):/backup busybox tar -C /data/meta --exclude='**/tmp' -c -f - . | gzip > meta.tar.gz
```

### Update bashrc on host

```bash
curl -L https://raw.githubusercontent.com/eremite/dotfiles/master/bashrc_devbox_host > bashrc_devbox_host
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
curl -L https://raw.githubusercontent.com/eremite/dotfiles/master/bashrc_devbox_host > bashrc_devbox_host
echo '. ./bashrc_devbox_host' >> .bashrc
sudo docker run -v /data --name=data eremite/devbox sudo chown -R dev:dev /data
source bashrc_devbox_host
```
