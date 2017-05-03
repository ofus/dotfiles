#!/usr/bin/env bash

ln -s $HOME/.dotfiles/tmux/tmux.conf.symlink .tmux.conf
ln -s $HOME/.dotfiles/git/gitconfig.symlink .gitconfig
ln -s $HOME/.dotfiles/eslintrc.symlink .eslintrc
ln -s $HOME/.dotfiles/jshintrc.symlink .jshintrc
ln -s $HOME/.dotfiles/jscsrc.symlink_excluded .jscsrc
ln -s $HOME/.dotfiles/jsbeautifyrc.symlink .jsbeautifyrc
ln -s $HOME/.dotfiles/git/gitignore_global.symlink .gitignore_global

command_exists() {
    type "$1" > /dev/null 2>&1
}

echo "Installing dotfiles."

if ! command_exists diff-so-fancy; then
    echo "installing diff-so-fancy"
    npm install -g diff-so-fancy
fi

echo "Done. Reload your terminal."

