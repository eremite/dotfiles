#!/bin/bash

set -x

app=${PWD##*/}
mkdir -p $META/$app/tmp
mkdir -p $META/$app/symlinks/.git
if [ -e $META/$app/docker_overrides.env ]; then
  cp $META/$app/docker_overrides.env .docker_overrides.env
fi
touch $META/$app/symlinks/notes.md
mv .git/config $META/$app/symlinks/.git
git checkout master
