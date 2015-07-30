VERSION=1.6.2
echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
DEBIAN_FRONTEND=noninteractive apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y lxc-docker-$VERSION

echo -n "checking docker..."
docker --version | grep $VERSION > /dev/null
[ "$?" -ne 0 ] && echo "no" && exit 1; echo "ok"
