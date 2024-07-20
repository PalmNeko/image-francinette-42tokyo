#!/usr/bin/bash

set -e

get_tag_list() {
	git ls-remote --tags https://github.com/xicodomingues/francinette.git \
	| awk '{print $2}' \
	| sed -E 's@refs/tags/@@g'
}

print_error() {
	printf "\e[31mError\e[m: %s\n" "$1"
}

validate_version() {
	VERSION="$1"

	if ! echo "$VERSION" | grep -E '^v[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+$'; then
		print_error "$VERSION: please version format: vX.Y.Z"
		echo "ex. v1.0.0"
		exit 1
	fi
	if [ "$(git tag -l "$VERSION")" != "" ]; then
		print_error "$VERSION: alrady exists"
		exit 1
	fi
	return 0
}

validate_francinette_tag_name() {
	TAG_NAME="$1"
	if [ "$(get_tag_list | grep "$TAG_NAME")" != "$TAG_NAME" ]; then
		print_error "$TAG_NAME: can't find tag-list"
		exit 1
	fi
}

overwrite() {
	REPO_VERSION="$1"
	FRANCINETTE_TAGNAME="$2"

	OLD_REPO_URL="https://raw.githubusercontent.com/PalmNeko/image-francinette-42tokyo/main/"
	NEW_REPO_URL="https://raw.githubusercontent.com/PalmNeko/image-francinette-42tokyo/$REPO_VERSION/"
	OLD_FRAN_URL="https://github.com/xicodomingues/francinette"
	NEW_FRAN_URL="https://github.com/xicodomingues/francinette/tree/$FRANCINETTE_TAGNAME"
	echo "TAG=$REPO_VERSION" > config/francinette/.env
	sed -i "s|$OLD_REPO_URL|$NEW_REPO_URL|g" README.md
	sed -i "s|$OLD_FRAN_URL|$NEW_FRAN_URL|g" README.md
}

main () {

	echo "this script overwrite version number..."
	sleep 1

	printf "please input this repository version > "
	read REPO_VERSION
	validate_version "$REPO_VERSION"

	printf "please input francinette tag name(branch) > "
	read FRANCINETTE_TAGNAME
	validate_francinette_tag_name "$FRANCINETTE_TAGNAME"

	echo
	echo "May I overwrite files with this information"
	echo "repository version: $REPO_VERSION"
	echo "francinette tag name: $FRANCINETTE_TAGNAME"
	printf "(y/n) > "
	read YN

	if [ "$YN" != "y" ]; then
		print_error 'aborting'
		exit 1
	fi
	overwrite "$REPO_VERSION" "$FRANCINETTE_TAGNAME"
	echo 'overwritten'
	echo "add tag $REPO_VERSION"
	git tag "$REPO_VERSION"
	echo
	echo "please check and push"
}

main
