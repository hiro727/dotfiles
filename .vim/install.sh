#~bin/sh
logfile=~/.vim/setup.log


function vimcopy() {
  repo=$1
  target=$2

  if [ -d $repo/$target ]; then
    echo "           $repo/$target --> ../$target/"
    cp -r $repo/$target/* ../$target/
  fi
}

function vimclone() {
  account=$1
  repo=$2
  url="https://github.com/$account/$repo.git"

  if [ ! -d $repo ]; then
    echo "Installing $repo"

    git clone $url &>> $logfile
    vimcopy $repo doc
    vimcopy $repo autoload
    vimcopy $repo plugin
  fi
}

function prepareclangformat() {

  if [ ! $(hash clang-format 2>/dev/null) ]; then 
    cd ../support
    cf=""

    if [ "$(uname)" == "Darwin" ]; then
      brew install clang-format &>> $logfile

      parent=$(which clang-format)
      parent=$(perl -MCwd -le 'print Cwd::abs_path(shift)' "$parent")
      cf=$(find $(dirname $(dirname "$parent")) | grep clang-format\.py)

    elif [ ! -d clang-format ]; then
      mkdir ./clang-format

      curl 'http://releases.llvm.org/3.9.1/clang+llvm-3.9.1-x86_64-linux-gnu-debian8.tar.xz' -o './clang-format/clang-format.tar.xz' |& tee -a $logfile
      tar xvfJ clang-format/clang-format.tar.xz -C ./clang-format &>> $logfile

      rm -f ~/bin/clang-format
      ln -s $(pwd)/$(find clang-format | grep bin/clang-format$) ~/bin/clang-format

      cf="$(pwd)/$(find clang-format | grep clang-format\.py)"
    fi

    cd ../bundle

    echo "Appending user specific clang format path to .vimrc -- $cf"
  fi
}

function setupycm() {

  if [ ! -d ../support/ycm ]; then
    cd YouCompleteMe

    git submodule update --init --recursive &>> $logfile

    if [ "$(uname)" == "Darwin" ]; then
      if [ ! $(hash cmake 2>/dev/null) ]; then 
        brew install cmake &>> $logfile
      fi
    fi

    ./install.py --tern-completer --clang-completer &>> $logfile

    cd ..

    git clone https://github.com/JDevlieghere/dotfiles.git ../support/ycm &>> $logfile
    cp ../support/ycm/.vim/.ycm_extra_conf.py ~/.ycm_extra_conf.py
  fi
}

function preparepowerline() {
  if [ ! -d ../support/powerline ]; then
    cd ../support

    git clone https://github.com/powerline/fonts.git powerline &>> $logfile
    powerline/install.sh

    cd ../bundle
  fi
}


function prepareag() {
  if [ ! -d ../support/ag ]; then
    mkdir ../support/ag
  fi
}


function setupall() {
  mkdir -p ~/.vim && cd ~/.vim/
  mkdir -p bundle doc autoload plugin support
  cd bundle

  vimclone 'nanotech' 'jellybeans.vim'

  vimclone 'Shougo' 'vimproc.vim'
  vimclone 'Shougo' 'unite.vim'
  vimclone 'Shougo' 'neosnippet.vim'
  vimclone 'Shougo' 'neosnippet-snippets'
  vimclone 'Shougo' 'neocomplete.vim'

  preparepowerline
  vimclone 'vim-airline' 'vim-airline'
  vimclone 'vim-airline' 'vim-airline-themes'

  vimclone 'ternjs' 'tern_for_vim'
  vimclone 'leafgarland' 'typescript-vim'
  vimclone 'Quramy' 'tsuquyomi'
  vimclone 'vim-syntastic' 'syntastic'

  prepareclangformat
  vimclone 'rhysd' 'vim-clang-format'
  vimclone 'Valloric' 'YouCompleteMe'
  setupycm

  prepareag
  vimclone 'ggreer' 'the_silver_searcher'
  vimclone 'rking' 'ag.vim'

  vimclone 'ctrlpvim' 'ctrlp.vim'
  vimclone 'scrooloose' 'nerdtree'
  vimclone 'tpope' 'vim-jdaddy'
  vimclone 'tpope' 'vim-fugitive'
  vimclone 'airblade' 'vim-gitgutter'
  vimclone 'skywind3000' 'asyncrun.vim'
  vimclone 'FooSoft' 'vim-argwrap'
  vimclone 'tpope' 'vim-surround'

  vimclone 'tpope' 'vim-rails'
  vimclone 'chrisbra' 'csv.vim'

  echo 'done'
}

setupall
