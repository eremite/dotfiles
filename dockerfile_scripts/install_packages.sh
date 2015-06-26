DEBIAN_FRONTEND=noninteractive apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get -y install \
  apt-transport-https `# docker requirement` \
  build-essential `# compile from source` \
  curl `# downloading` \
  exuberant-ctags `# tags in vim` \
  git-core `# version control` \
  libterm-readkey-perl `# git singlekey interactive` \
  tmux `# terminal multiplexer` \
  vim-nox `# editor` \
  wget `# downloading`

echo -n "checking vim..."
vim --version | grep vim > /dev/null
[ "$?" -ne 0 ] && echo "no" && exit 1; echo "ok"

echo -n "checking git..."
git version | grep git > /dev/null
[ "$?" -ne 0 ] && echo "no" && exit 1; echo "ok"

echo -n "checking tmux..."
tmux -V | grep tmux > /dev/null
[ "$?" -ne 0 ] && echo "no" && exit 1; echo "ok"

echo -n "checking wget..."
wget --version | grep wget > /dev/null
[ "$?" -ne 0 ] && echo "no" && exit 1; echo "ok"

echo -n "checking curl..."
curl --version | grep curl > /dev/null
[ "$?" -ne 0 ] && echo "no" && exit 1; echo "ok"
