#!/usr/bin/env bash

ln -s $HOME/.dotfiles/tmux/tmux.conf.symlink $HOME/.tmux.conf
ln -s $HOME/.dotfiles/git/gitconfig.symlink $HOME/.gitconfig
ln -s $HOME/.dotfiles/eslintrc.symlink $HOME/.eslintrc
ln -s $HOME/.dotfiles/jshintrc.symlink $HOME/.jshintrc
ln -s $HOME/.dotfiles/jscsrc.symlink_excluded $HOME/.jscsrc
ln -s $HOME/.dotfiles/jsbeautifyrc.symlink $HOME/.jsbeautifyrc
ln -s $HOME/.dotfiles/git/gitignore_global.symlink $HOME/.gitignore_global
ln -s $HOME/.dotfiles/editorconfig.symlink $HOME/.editorconfig
ln -s $HOME/.dotfiles/dircolors.symlink $HOME/.dircolors
ln -s $HOME/.dotfiles/sqliterc.symlink $HOME/.sqliterc

ln -s $HOME/.dotfiles/config/youtube-dl $HOME/.config/youtube-dl

command_exists() {
    type "$1" > /dev/null 2>&1
}

echo "Installing dotfiles."

if ! command_exists diff-so-fancy; then
    echo "installing diff-so-fancy"
    npm install -g diff-so-fancy
fi

echo "Done. Reload your terminal."

