#!/usr/bin/env bash
set -e # halt script on error

bundle exec jekyll build
#bundle exec htmlproofer ./docs

git config --global user.email "jeanbaptiste.richardet@gmail.com"
git config --global user.name "JbIPS (Travis Bot)"

git checkout master
AUTHOR=$(git log --format="%an" | head -n 1)
if ! echo "$AUTHOR" | grep 'Bot'; then
  git add docs
  git commit -m 'Updates generated site'
  git status
  git push https://$GH_TOKEN@github.com/ARPHD/ARPHD.git master
fi
