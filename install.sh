#!/usr/bin/bash

set -e

REPO_NAME="francinette-image-42tokyo"
BRANCH_NAME="main"
INSTALLDIR="${INSTALLDIR:-"$HOME/bin"}"
cd "$INSTALLDIR" || exit 1
INSTALLDIR="$(pwd)"
PROJECT_PATH="$INSTALLDIR/$REPO_NAME"

test -d "$PROJECT_PATH" || git clone git@github.com:PalmNeko/"$REPO_NAME".git --depth 1 -b "$BRANCH_NAME" "$REPO_NAME"

TEST_SCRIPT="$PROJECT_PATH/test.sh"
chmod u+x "$TEST_SCRIPT"

APPEND_TEXT="
# append from $REPO_NAME
alias paco='$TEST_SCRIPT'
alias francinette='$TEST_SCRIPT'
"
if [ -f ~/.zshrc ]; then
	echo "$APPEND_TEXT" >> ~/.zshrc
fi
if [ -f ~/.bashrc ]; then
	echo "$APPEND_TEXT" >> ~/.bashrc
fi
