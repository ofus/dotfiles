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

if [[ ! -e "resources/.added" ]]; then
    read -p "Install NPM and packages? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if ! command_exists npm; then
            echo "installing npm"
            sudo apt-get install -y npm
        fi

        if ! command_exists diff-so-fancy; then
            echo "installing diff-so-fancy"
            npm install -g diff-so-fancy
        fi

        if ! command_exists js-beautify; then
            echo "installing js-beautify"
            npm install -g js-beautify
        fi

        if ! command_exists jscs; then
            echo "installing jscs"
            npm install -g jscs
        fi

        if ! command_exists jshint; then
            echo "installing jshint"
            npm install -g jshint
        fi

        if ! command_exists eslint; then
            echo "installing eslint"
            npm install -g eslint
        fi

    fi
fi

echo "Done. Reload your terminal."

