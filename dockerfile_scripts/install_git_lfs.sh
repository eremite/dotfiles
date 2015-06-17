VERSION=0.5.1
wget https://github.com/github/git-lfs/releases/download/v$VERSION/git-lfs-linux-amd64-$VERSION.tar.gz
tar -zxf git-lfs-linux-amd64-$VERSION.tar.gz
cp git-lfs-$VERSION/git-lfs /usr/local/bin
rm -r git-lfs*

echo -n "checking git lfs..."
git lfs version | grep $VERSION > /dev/null
[ "$?" -ne 0 ] && echo "no" && exit 1; echo "ok"
