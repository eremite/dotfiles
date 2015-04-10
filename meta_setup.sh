#!/bin/bash

set -x

app=${PWD##*/}
mkdir -p $META/$app/tmp
mkdir -p $META/$app/symlinks/.git
touch $META/$app/symlinks/notes.md
mv .git/config $META/$app/symlinks/.git
git checkout master
