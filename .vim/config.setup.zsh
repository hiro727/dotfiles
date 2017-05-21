function vimhome() {
  cd ~/.vim/bundle
}

# PREscript
function setup_clang_format() {
  hash clang-format 2>/dev/null
  if [ $? -ne 0 ]; then
    cd ~/.vim/support
    cf=""

    if [ ! -d vim-clang-format ]; then
      if [ "$(uname)" = "Darwin" ]; then
        brew install clang-format >> $logfile 2>&1
        mkdir vim-clang-format

        parent=$(which clang-format)
        parent=$(perl -MCwd -le 'print Cwd::abs_path(shift)' "$parent")
        cf=$(find $(dirname $(dirname "$parent")) | grep clang-format\.py)

      else
        curl 'http://releases.llvm.org/3.9.1/clang+llvm-3.9.1-x86_64-linux-gnu-debian8.tar.xz' -o './clang-format.tar.xz' >> $logfile 2>&1
        tar xvfJ clang-format.tar.xz -C vim-clang-format >> $logfile 2>&1
        rm -f clang-format.tar.xz

        rm -f ~/bin/clang-format
        ln -s $(pwd)/$(find clang-format | grep bin/clang-format$) ~/bin/clang-format

        cf="$(pwd)/$(find clang-format | grep clang-format\.py)"
      fi

      printf "Clang Format created at: %s", "$cf"
    fi

    vimhome
  fi
}

# POSTscript
function setup_ycm() {
  vimhome
  if [ ! -d ../support/YouCompleteMe ]; then
    cd YouCompleteMe

    git submodule update --init --recursive >> $logfile 2>&1

    if [ "$(uname)" = "Darwin" ]; then
      if [ ! $(hash cmake 2>/dev/null) ]; then
        brew install cmake >> $logfile 2>&1
      fi
    fi

    ./install.py --tern-completer --clang-completer >> $logfile 2>&1

    cd ..

    git clone https://github.com/JDevlieghere/dotfiles.git ../support/YouCompleteMe >> $logfile 2>&1
    cp ../support/YouCompleteMe/.vim/.ycm_extra_conf.py ~/.ycm_extra_conf.py
  fi
}

# PREscript
function setup_powerline() {
  vimhome
  if [ ! -d ../support/vim-airline ]; then
    cd ../support

    git clone https://github.com/powerline/fonts.git vim-airline >> $logfile 2>&1
    vim-airline/install.sh

    vimhome
  fi
}

# PREscript
function setup_ag() {
  vimhome
  if [ ! -d ../support/the_silver_searcher  ]; then
    # mkdir ../support/the_silver_searcher
    # TODO brew install ag for Darwin & some other for other OS
  fi
}

