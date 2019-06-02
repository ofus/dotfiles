#!/usr/bin/env bash

[[ ! -e "$HOME/.tmux.conf" ]] && ln -s "$HOME/.dotfiles/tmux/tmux.conf.symlink" "$HOME/.tmux.conf"
[[ ! -e "$HOME/.gitconfig" ]] && ln -s "$HOME/.dotfiles/git/gitconfig.symlink" "$HOME/.gitconfig"
[[ ! -e "$HOME/.eslintrc" ]] && ln -s "$HOME/.dotfiles/eslintrc.symlink" "$HOME/.eslintrc"
[[ ! -e "$HOME/.jshintrc" ]] && ln -s "$HOME/.dotfiles/jshintrc.symlink" "$HOME/.jshintrc"
[[ ! -e "$HOME/.jscsrc" ]] && ln -s "$HOME/.dotfiles/jscsrc.symlink_excluded" "$HOME/.jscsrc"
[[ ! -e "$HOME/.jsbeautifyrc" ]] && ln -s "$HOME/.dotfiles/jsbeautifyrc.symlink" "$HOME/.jsbeautifyrc"
[[ ! -e "$HOME/.gitignore_global" ]] && ln -s "$HOME/.dotfiles/git/gitignore_global.symlink" "$HOME/.gitignore_global"
[[ ! -e "$HOME/.editorconfig" ]] && ln -s "$HOME/.dotfiles/editorconfig.symlink" "$HOME/.editorconfig"
[[ ! -e "$HOME/.dircolors" ]] && ln -s "$HOME/.dotfiles/dircolors.symlink" "$HOME/.dircolors"
[[ ! -e "$HOME/.sqliterc" ]] && ln -s "$HOME/.dotfiles/sqliterc.symlink" "$HOME/.sqliterc"

command_exists() {
    type "$1" > /dev/null 2>&1
}

function install_dotfiles_package()
{
    local PACKAGE=$1

    if ! command_exists $PACKAGE; then
        read -p "Install $PACKAGE? " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "installing $PACKAGE"
            npm install -g $PACKAGE
        fi
    fi
}

echo "Installing dotfiles."

if [[ ! -e "resources/.added" ]]; then
    read -p "Install truecolor + italics support? (requires sudo) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      for I in $(ls resources); do sudo tic resources/$I; done
      echo > "resources/.added"
      echo "Done"
    fi
fi

if ! command_exists npm; then
    read -p "Install NPM? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if ! command_exists npm; then
            echo "installing npm"
            sudo apt-get install -y npm
        fi
    fi
fi

install_dotfiles_package js-beautify
install_dotfiles_package jscs
install_dotfiles_package jshint
install_dotfiles_package eslint

echo "Done. Reload your terminal."

