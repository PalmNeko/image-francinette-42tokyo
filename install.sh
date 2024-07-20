#!/usr/bin/bash

set -e

REPO_NAME="francinette-image-42tokyo"
BRANCH_NAME="main"
INSTALLDIR="${INSTALLDIR:-"$HOME/bin"}"
cd "$INSTALLDIR" || exit 1
INSTALLDIR="$(pwd)"
PROJECT_PATH="$INSTALLDIR/$REPO_NAME"

git clone git@github.com:PalmNeko/"$REPO_NAME".git --depth 1 -b "$BRANCH_NAME" "$REPO_NAME"

if [ -f "~/.zshrc" ]; then
	echo "alias paco='$PROJECT_PATH/test.sh'" >> "~/.zshrc"
	echo "alias francinette='$PROJECT_PATH/test.sh'" >> "~/.zshrc"
fi
if [ -f "~/.bashrc" ]; then
	echo "alias paco='$PROJECT_PATH/test.sh'" >> "~/.zshrc"
	echo "alias francinette='$PROJECT_PATH/test.sh'" >> "~/.zshrc"
fi
