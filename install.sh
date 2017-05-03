#!/usr/bin/env bash

ln -s tmux/tmux.conf.symlink $HOME/.tmux.conf
ln -s git/gitconfig.symlink $HOME/.gitconfig
ln -s eslintrc.symlink $HOME/.eslintrc
ln -s jshintrc.symlink $HOME/.jshintrc
ln -s jscsrc.symlink_excluded $HOME/.jscsrc
ln -s jsbeautifyrc.symlink $HOME/.jsbeautifyrc
ln -s git/gitignore_global.symlink $HOME/.gitignore_global
ln -s editorconfig.symlink $HOME/.editorconfig

command_exists() {
    type "$1" > /dev/null 2>&1
}

echo "Installing dotfiles."

if ! command_exists diff-so-fancy; then
    echo "installing diff-so-fancy"
    npm install -g diff-so-fancy
fi

echo "Done. Reload your terminal."

