#!/usr/bin/env bash
set -e # halt script on error

bundle exec jekyll build
#bundle exec htmlproofer ./docs

git config --global user.email "jeanbaptiste.richardet@gmail.com"
git config --global user.name "JbIPS (Travis Bot)"

git branch -a
git checkout master
git remote -v
git status
git add docs
git commit -m 'Updates generated site'
git status
git push https://$GH_TOKEN@github.com/ARPHD/ARPHD.git master
