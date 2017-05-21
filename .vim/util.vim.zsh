# Just move to ~/.vim/bundle
function vimcd() {
  mkdir -p ~/.vim && cd ~/.vim/
  mkdir -p bundle doc autoload plugin support && cd bundle
}

# Copy ~/.vim/plugin/whatever/$SUPPORT/* to ~/.vim/$SUPPORT/*
function vimcopy() {
  repo=$1

  for target in $SUPPORT; do
    if [ -d $repo/$target ]; then
      echo "           $repo/$target --> ../$target/"
      cp -r $repo/$target/* ../$target/
    fi
  done
}

# Clone plugin from username/repository names if not installed yet
function vimclone() {
  user=$1
  repo=$2
  url="git@github.com:$user/$repo.git"

  if [ ! -d $repo ]; then
    echo "Installing $repo"

    git clone $url >> $logfile 2>&1
    vimcopy $repo
  else
    echo "Skipping $repo"
  fi
}
