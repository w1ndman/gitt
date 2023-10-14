#!/bin/bash
# set -e

# alias gitt="git --git-dir .gitback"
mkdir -p .gitt
exec 1>.gitt/gittout.txt
exec 2>.gitt/gitterror.txt

logfiles=(
    ".gitt/gittout.txt"
    ".gitt/gitterror.txt"
)
for file in "${logfiles[@]}"; do
    if [ ! -x "$file" ] ; then
        echo "touch $file"
        touch $file
    fi
done


# if [ ! -d ".git" ] || [ ! -d ".gitback" ]; then
if [ ! -d ".gitback" ] ; then
    echo "Error: .gitback folder NOT found in the current directory."
    exit 1
fi


while true; do
    current_time=$(date "+%Y-%m-%d %H:%M:%S")
    git --git-dir .gitback add .
    git --git-dir .gitback commit -m "$current_time"
    echo "------- done -------- $current_time "
    sleep 5
done


# gitt_run_