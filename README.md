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

### Back up meta

```bash
docker run --rm --volumes-from data -v $(pwd):/backup busybox tar -C /data/meta --exclude='**/tmp' -c -f - . | gzip > meta.tar.gz
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
sudo docker run -v /data --name=data eremite/devbox sudo chown -R dev:dev /data
sudo docker run -v /var/lib/mysql -v /var/lib/postgresql/data -v /var/lib/elasticsearch --name db_data eremite/devbox true
sudo docker run --volumes-from=db_data --rm -i -t eremite/devbox bash --login
sudo chown -R dev:dev /var/lib/mysql /var/lib/postgresql/data /var/lib/elasticsearch
printf "path:\n  logs: /var/lib/elasticsearch/log\n  data: /var/lib/elasticsearch/data\n" > /var/lib/elasticsearch/config.yml
exit
source devbox
```
