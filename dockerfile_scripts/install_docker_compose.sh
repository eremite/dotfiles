VERSION=1.2.0
curl -L https://github.com/docker/compose/releases/download/$VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo -n "checking docker-compose..."
docker-compose --version | grep $VERSION > /dev/null
[ "$?" -ne 0 ] && echo "no" && exit 1; echo "ok"
