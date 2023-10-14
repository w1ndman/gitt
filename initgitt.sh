#!/bin/bash

gitt_init() {
    if [ -d .git ] || [ -d .gitback ]; then
        echo "Error: .git or code folder found in the current directory."
        exit 1
    fi

    # if [ ! -x ".gitignore" ] ; then
    #     echo "touch .gitignore"
    #     touch .gitignore
    # fi

    set -e
    script_dir=$(cd "$(dirname "$0")" && pwd)
    # git config --global core.excludesFile "$script_dir/.gittignore"
    
    mkdir gitback && cd gitback
    # git config advice.statusHints false
    git init -q
    mv ./.git ../.gitback
    cd ../ && rmdir gitback
    git --git-dir .gitback config core.excludesFile "$script_dir/.gittignore"

    # echo ".gitback/" >> .gitignore
    # echo ".gitt/" >> .gitignore

    git --git-dir .gitback add .
    git --git-dir .gitback commit -m "init gitt"


    mkdir -p ./.gitt
    # git init
    if [ ! -d .git ]; then
        read -p "git init? [y/n] " answer
        if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
            git init
            git config core.excludesFile "$script_dir/.gittignore"
        else
            echo "cancel"
        fi
    fi

}
