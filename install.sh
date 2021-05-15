apt install nodejs npm clang -y
cd
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
rm -rf ~/.vimrc
cd Vimrc; mv .vimrc $HOME
