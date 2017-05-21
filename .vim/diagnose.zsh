#!/bin/zsh

original=$(pwd)

source $(dirname $0)/config.zsh
source $(dirname $0)/util.vim.zsh
source $(dirname $0)/util.table.zsh

# Check what's installed on system
function diagnose() {
  flags=("$@")
  printf 'Running system check on plugins\n\n'

  vimcd
  h_user=author
  h_repo=repository
  h_optn=flag
  maxuser=${#h_user}
  maxrepo=${#h_repo}
  maxoptn=${#h_optn}
  maxsubd=0

  # Compute max width for each cell & line
  for gitrepo in $REPOS; do
    arr=(${(ps: :)${gitrepo}}); user=$arr[1]; repo=$arr[2]; optn=$arr[3]
    if (( ${#user} > $maxuser )); then maxuser=${#user}; fi
    if (( ${#repo} > $maxrepo )); then maxrepo=${#repo}; fi
    if (( ${#optn} > $maxoptn )); then maxoptn=${#optn}; fi
  done

  for subd in $SUPPORT; do
    if (( ${#subd} > $maxsubd)); then maxsubd=${#subd}; fi
  done

  # For margin
  (( maxuser = maxuser + 1 ))
  (( maxrepo = maxrepo + 1 ))
  (( maxsubd = maxsubd + ( maxsubd & 1 == 0 ) )) # odd-length
  (( linewidth = maxuser + maxrepo + maxsubd + maxoptn + 63 )) # TODO calculate dynamically

  # Print out header
  grid $linewidth; printf '|'
  center $h_user $maxuser; printf '|'
  center $h_repo $maxrepo; printf '|'
  center $h_optn $maxoptn

  printf '|     status    |'

  for subd in $SUPPORT; do
    center $subd $maxsubd; printf '|'
  done
  center 'support' $maxsubd; printf '|\n'
  grid $linewidth

  # Print out status of each plugin
  for gitrepo in $REPOS; do
    arr=(${(ps: :)${gitrepo}})
    user=$arr[1]; repo=$arr[2]; optn=$arr[3]; pre=$arr[4]

    shouldInstall=0

    if [ -z $optn ]; then
      optn=' ';
      shouldInstall=1
    else
      for flag in $flags; do
        if [ $optn = $flag ]; then shouldInstall=1; break; fi
      done
    fi

    if [ $shouldInstall = 1 ]; then
      colgreen="\e[1;32m"
      colred="\e[1;31m"
      uncol="\e[0m"
    else
      colgreen=
      colred=
      uncol=
    fi

    if [ -d $repo ]; then
      col=$colgreen
    else
      col=$colred
    fi

    # Print out author/name of plugin and cli flag for optional installs
    printf "$uncol| $col"; left $user $(( maxuser - ${#user} ))
    printf "$uncol| $col"; left $repo $(( maxrepo - ${#repo} ))
    printf "$uncol| $col"; left $optn $(( maxoptn - ${#optn} ))
    printf "$uncol"

    if [ -d $repo ]; then
      printf '|   INSTALLED   |'
    else
      printf '|  UNINSTALLED  |'
    fi

    # Print out which sub package exist for each plugin
    for subd in $SUPPORT; do
      if [ -d $repo/$subd ]; then ex=$(printf "\xE2\x9C\x94\n"); else ex=' '; fi
      center $ex $maxsubd; printf '|'
    done

    if [ -d ../support/$repo ]; then
      ex=$(printf "\xE2\x9C\x94")
    elif [[ $pre == setup_* ]]; then
      ex=$(printf "\xE2\x9D\x8C")
    else
      ex=' '
    fi

    center $ex $maxsubd; printf '|\n'
  done

  grid $linewidth

  cd $original
}

if [ "$1" != "--silent" ]; then diagnose $@; fi
