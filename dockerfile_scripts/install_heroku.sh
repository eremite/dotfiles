wget -qO- https://toolbelt.heroku.com/install.sh | sh

echo -n "checking for heroku..."
/usr/local/heroku/bin/heroku --version | grep heroku > /dev/null
[ "$?" -ne 0 ] && echo "no" && exit 1; echo "ok"
