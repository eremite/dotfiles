#!/usr/bin/env bash

sudo yum -y update
heroku update
vim -c 'PlugUpdate'
