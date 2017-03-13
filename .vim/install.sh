mkdir -p ~/.vim/bundle && cd ~/.vim/bundle
mkdir -p ~/.vim/tmp

echo 'starting plugin install'
if [ ! -d tern_for_vim ]; then
  git clone https://github.com/ternjs/tern_for_vim.git
fi

if [ ! -d vim-clang-format ]; then
  git clone https://github.com/rhysd/vim-clang-format.git
fi

if [ ! -d YouCompleteMe ]; then
  git clone https://github.com/Valloric/YouCompleteMe.git
  cd YouCompleteMe
  git submodule update --init --recursive

  if [ "$(uname)" == "Darwin" ]; then
    output=$( brew ls --version cmake )
    if [[ $? != 0 || $output == "" ]]; then
      brew install cmake
    fi
  fi
  ./install.py --tern-completer --clang-completer

  cd ../../tmp

  if [ ! -d dotfiles ]; then
    git clone https://github.com/JDevlieghere/dotfiles.git dotfiles
    cp dotfiles/.vim/.ycm_extra_conf.py ~/.ycm_extra_conf.py
  fi

  if [ ! $(hash clang-format 2>/dev/null) ]; then 
    cf=""

    if [ "$(uname)" == "Darwin" ]; then
      brew install clang-format

      parent=$(which clang-format)
      parent=$(perl -MCwd -le 'print Cwd::abs_path(shift)' "$parent")
      cf=$(find $(dirname $(dirname "$parent")) | grep clang-format\.py)

    elif [ ! -d clang-format ]; then
      mkdir ./clang-format

      curl 'http://releases.llvm.org/3.9.1/clang+llvm-3.9.1-x86_64-linux-gnu-debian8.tar.xz' -o './clang-format/clang-format.tar.xz'
      tar xvfJ clang-format/clang-format.tar.xz -C ./clang-format
      rm -f ~/bin/clang-format

      ln -s $(pwd)/$(find clang-format | grep bin/clang-format$) ~/bin/clang-format

      cf="$(pwd)/$(find clang-format | grep clang-format\.py)"
    fi

    echo $cf
    echo "map <C-I> :1,\$pyf $cf<CR>" >> ~/.vimrc
    echo "imap <C-I> <ESC>:1,\$pyf $cf<CR>i" >> ~/.vimrc
    echo "autocmd bufwritepost *.cpp,*.h silent :1,\$pyf $cf" >> ~/.vimrc

    cd ../bundle
  fi

fi

if [ ! -d vimproc.vim ]; then
  git clone https://github.com/Shougo/vimproc.vim.git
fi

if [ ! -d vim-rails ]; then
  git clone https://github.com/tpope/vim-rails.git
fi

if [ ! -d the_silver_searcher ]; then
  git clone https://github.com/ggreer/the_silver_searcher.git
fi

if [ ! -d ag.vim ]; then
  git clone https://github.com/rking/ag.vim.git
fi

if [ ! -d typescript-vim ]; then
  git clone https://github.com/leafgarland/typescript-vim.git
fi

if [ ! -d tsuquyomi ]; then
  git clone https://github.com/Quramy/tsuquyomi.git
fi

if [ ! -d syntastic ]; then
  git clone https://github.com/vim-syntastic/syntastic.git
fi

if [ ! -d ctrlp.vim ]; then
  git clone https://github.com/ctrlpvim/ctrlp.vim.git
fi

if [ ! -d nerdtree ]; then
  git clone https://github.com/scrooloose/nerdtree.git
fi

if [ ! -d unite.vim ]; then
  git clone https://github.com/Shougo/unite.vim.git
fi

if [ ! -d vim-airline ]; then
  git clone https://github.com/vim-airline/vim-airline.git
  git clone https://github.com/vim-airline/vim-airline-themes.git
  git clone https://github.com/powerline/fonts.git ../tmp/fonts.git
  ../tmp/fonts.git/install.sh
fi

if [ ! -d vim-jdaddy ]; then
  git clone https://github.com/tpope/vim-jdaddy.git
fi

if [ ! -d vim-fugitive ]; then
  git clone https://github.com/tpope/vim-fugitive.git
fi

if [ ! -d vim-gitgutter ]; then
  git clone https://github.com/airblade/vim-gitgutter.git
fi

if [ ! -d asyncrun.vim ]; then
  git clone https://github.com/skywind3000/asyncrun.vim.git
fi

if [ ! -d neosnippet.vim ]; then
  git clone https://github.com/Shougo/neosnippet.vim.git
fi

if [ ! -d neosnippet-snippets ]; then
  git clone https://github.com/Shougo/neosnippet-snippets.git
fi

if [ ! -d neocomplete.vim ]; then
  git clone https://github.com/Shougo/neocomplete.vim.git
fi

if [ ! -d vim-argwrap ]; then
  git clone https://github.com/FooSoft/vim-argwrap.git
fi

if [ ! -d vim-surround ]; then
  git clone https://github.com/tpope/vim-surround.git
fi

echo 'Installing Colour Themes'

if [ ! -d jellybeans.vim ]; then
  git clone https://github.com/nanotech/jellybeans.vim.git
fi

echo 'done'
