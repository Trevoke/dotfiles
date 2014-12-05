#!/bin/bash

for i in `ls`
do
  cd $i
  echo "-    -    -    -    -"
  last_commit_date=`git log --format="format:%ad" | head -1`
  git pull -q
  new_commit_date=`git log --format="format:%ad" | head -1`
  new_commit_date_relative=`git log --relative-date --format="format:%ad" | head -1`
  if [ "$last_commit_date" == "$new_commit_date" ]
  then
      echo "$i was not updated since the last time you fetched updates."
  else
      echo "$i was last updated $new_commit_date_relative."
  fi
  cd ..
done
