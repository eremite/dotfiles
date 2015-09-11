VERSION=1.7.1
FULL_VERSION=1.7.1-0~trusty # apt-cache madison ^docker-engine
echo deb https://apt.dockerproject.org/repo ubuntu-trusty main > /etc/apt/sources.list.d/docker.list
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
DEBIAN_FRONTEND=noninteractive apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y docker-engine=$FULL_VERSION

echo -n "checking docker..."
docker --version | grep $VERSION > /dev/null
[ "$?" -ne 0 ] && echo "no" && exit 1; echo "ok"
