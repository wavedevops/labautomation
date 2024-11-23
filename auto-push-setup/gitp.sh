#!/bin/bash

FILE=~/.count

git_push () {
      variableCount=$(cat ~/.count)
      git add .
      echo $(($(cat ~/.count) + 1)) > ~/.count
      git commit -m "automated commit #$variableCount"
      git push
}

if [ -f $FILE ]; then
  git_push
else
  echo "0" > ~/.count
  git_push
fi
