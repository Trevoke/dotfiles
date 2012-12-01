#!/bin/bash

for i in `ls`
do
  cd $i
  echo "----------------------------------"
  echo "Now working with .... $i !"
  git pull -q
  cd ..
done
