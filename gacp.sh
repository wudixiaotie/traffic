#!/bin/sh

rm -rf .byebug_history

if [ -n "$1" ] ;then
  note=$1
else
  note="new update"
fi

git add -A
git commit -m "$note"
git push origin master
git push heroku master