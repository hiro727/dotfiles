#!/bin/zsh
logfile=~/.vim/setup.log
original=$(pwd)

source $(dirname $0)/diagnose.zsh --silent
source $(dirname $0)/config.setup.zsh

function install() {
  flags=("$@")
  vimcd
  echo '\nInstalling missing plugins...\n'

  for gitrepo in $REPOS; do
    arr=(${(ps: :)${gitrepo}})
    user=$arr[1]; repo=$arr[2]
    option=$arr[3]
    pre=$arr[4]; post=$arr[5]

    shouldInstall=0

    if [ -z $option ]; then
      shouldInstall=1
    else
      for flag in $flags; do
        if [ $option = $flag ]; then shouldInstall=1; break; fi
      done
    fi

    if [ $shouldInstall = 1 ]; then
      if [[ $pre == setup_* ]]; then eval $pre; fi
      vimclone $user $repo
      if [[ $post == setup_* ]]; then eval $post; fi
    fi
  done

  echo '\nInstalling finished successfully'
}

flags=("$@")

diagnose $@

shouldInstall=1
for flag in $flags; do
  if [ "$flag" = '--diagnose' ]; then shouldInstall=0; fi
done

if [ $shouldInstall -eq 1 ]; then install $@; fi

cd $original
