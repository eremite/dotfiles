## Installation

Use [rcm](https://github.com/thoughtbot/rcm)

## Notes on using the devbox

### Initialize boot2docker

```bash
boot2docker init --memory=4096 --disksize=80000
```

### Build the Dockerfile

```bash
docker build --force-rm -t eremite/devbox .
```

### Create a data container

```bash
docker run -v /data --name data busybox true # old way
docker run -v /data --name=data eremite/devbox sudo chown -R dev:dev /data
```

### Upgrade boot2docker

```bash
boot2docker stop; boot2docker download; boot2docker up
```

### Back up meta

```bash
docker run --rm --volumes-from data -v $(pwd):/backup busybox tar -C /data/meta --exclude='**/tmp' -c -f - . | gzip > meta.tar.gz
```

### Install/upgrade bashrc for host

```bash
curl -L https://raw.githubusercontent.com/eremite/dotfiles/master/bashrc_devbox_host > .bashrc
```

### Run the devbox!

```bash
docker run -it --rm --name=devbox -v /Users/daniel:/data -v /var/run/docker.sock:/var/run/docker.sock eremite/devbox /bin/bash --login
```
