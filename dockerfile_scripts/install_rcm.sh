VERSION=1.2.3
wget https://thoughtbot.github.io/rcm/debs/rcm_$VERSION-1_all.deb
dpkg -i rcm_$VERSION-1_all.deb
rm rcm_$VERSION-1_all.deb

echo -n "checking rcup..."
rcup -V | grep $VERSION > /dev/null
[ "$?" -ne 0 ] && echo "no" && exit 1; echo "ok"
