VERSION=2.2.1
wget https://github.com/github/hub/releases/download/v$VERSION/hub-linux-amd64-$VERSION.tar.gz
tar -zxf hub-linux-amd64-$VERSION.tar.gz
cp hub-linux-amd64-$VERSION/hub /usr/local/bin
rm -r hub*

echo -n "checking github hub..."
hub version | grep $VERSION > /dev/null
[ "$?" -ne 0 ] && echo "no" && exit 1; echo "ok"
