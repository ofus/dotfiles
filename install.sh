#!/usr/bin/env bash

command_exists() {
    type "$1" > /dev/null 2>&1
}

install_dotfiles_package() {
    local PACKAGE=$1

    if ! command_exists "$PACKAGE"; then
        read -p "Install $PACKAGE? " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if ! command_exists npm; then
                echo "NPM not found, so we can't install $PACKAGE"
            else 
                echo "installing $PACKAGE"
                npm install -g "$PACKAGE"
            fi
        fi
    fi
}

# export TMUX_PLUGIN_MANAGER_PATH=~/.tmux/plugins/tpm/

if command_exists apt; then
    INSTALL_CMD="sudo apt install -y "
elif command_exists yum; then
    INSTALL_CMD="sudo yum install -y "
elif command_exists apt-cyg; then
    INSTALL_CMD="apt-cyg install "
elif command_exists pacman; then
    INSTALL_CMD="sudo pacman -Sl "    
else
    INSTALL_CMD="I don't know how to install software packages on this system, can't install "
fi

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ~/.tmux/plugins/tpm/bin/install_plugins
else
    ~/.tmux/plugins/tpm/bin/update_plugins all
fi

mkdir -p ~/.oldtmux~
[[ -h "$HOME/.tmux.conf" ]] && rm ~/.tmux.conf
[[ -e "$HOME/.tmux.conf" ]] && mv ~/.tmux.conf "$HOME/.oldtmux~/.tmux.conf.bak.$(date +%Y%m%d%H%M%S)~"
[[ -h "$HOME/.tmux/tmux.conf" ]] && rm ~/.tmux/tmux.conf
[[ -e "$HOME/.tmux/tmux.conf" ]] && mv ~/.tmux/tmux.conf "$HOME/.tmux/.tmux.conf.bak.$(date +%Y%m%d%H%M%S)~"
ln -s "$DOTFILES_DIR/tmux/tmux.conf.symlink" ~/.tmux.conf
[[ ! -e "$HOME/.gitconfig" ]] && ln -s "$DOTFILES_DIR/git/gitconfig.symlink" ~/.gitconfig
[[ ! -e "$HOME/.gitignore_global" ]] && ln -s "$DOTFILES_DIR/git/gitignore_global.symlink" ~/.gitignore_global
[[ ! -e "$HOME/.eslintrc" ]] && ln -s "$DOTFILES_DIR/eslintrc.symlink" ~/.eslintrc
[[ ! -e "$HOME/.jshintrc" ]] && ln -s "$DOTFILES_DIR/jshintrc.symlink" ~/.jshintrc
[[ ! -e "$HOME/.jscsrc" ]] && ln -s "$DOTFILES_DIR/jscsrc.symlink_excluded" ~/.jscsrc
[[ ! -e "$HOME/.jsbeautifyrc" ]] && ln -s "$DOTFILES_DIR/jsbeautifyrc.symlink" ~/.jsbeautifyrc
[[ ! -e "$HOME/.editorconfig" ]] && ln -s "$DOTFILES_DIR/editorconfig.symlink" ~/.editorconfig
[[ ! -e "$HOME/.dircolors" ]] && ln -s "$DOTFILES_DIR/dircolors.symlink" ~/.dircolors
[[ ! -e "$HOME/.sqliterc" ]] && ln -s "$DOTFILES_DIR/sqliterc.symlink" ~/.sqliterc

echo "Installing dotfiles."

if [[ ! -e "$DOTFILES_DIR/resources/.added" ]]; then
    read -p "Install truecolor + italics support?" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        for I in "$DOTFILES_DIR/resources/*"; do tic "$I"; done
        echo > "$DOTFILES_DIR/resources/.added"
        echo "Done"
    fi
fi

if ! command_exists npm; then
    read -p "Install NPM? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "installing npm..."
        $INSTALL_CMD npm
    fi
fi

install_dotfiles_package js-beautify
install_dotfiles_package jscs
install_dotfiles_package jshint
install_dotfiles_package eslint

read -p "Customize Vim? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if ! command_exists vim; then
        $INSTALL_CMD vim
    fi
    [[ -e "$HOME/.vimrc" ]] && mv ~/.vimrc "$HOME/.vimrc.bak.$(date +%Y%m%d%H%M%S)~"
    ln -s "$DOTFILES_DIR/vimrc.symlink" ~/.vimrc
    [[ ! -d "$HOME/.vim/bundle/Vundle.vim" ]] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
fi

echo "Done. Reload your terminal."
