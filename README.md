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
docker run -v /data --name data busybox true
```

### Upgrade boot2docker

```bash
boot2docker stop; boot2docker download; boot2docker up
```

### Sync /data to host OS

```bash
docker run --rm -v /usr/local/bin/docker:/docker -v /var/run/docker.sock:/docker.sock svendowideit/samba data
sudo mkdir -p /Volumes/personal; sudo mount_smbfs //guest@192.168.59.103/data /Volumes/data
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
docker run -it --rm --volumes-from data -v /var/run/docker.sock:/var/run/docker.sock eremite/devbox /bin/bash --login
```
