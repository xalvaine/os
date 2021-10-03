#!/bin/bash

TRASH_PATH="$HOME/.fake_trash"

if ! [ -d "$TRASH_PATH" ]; then
  mkdir "$TRASH_PATH"
fi

delete() {
  for filename in "$@"; do
    if test -f "$TRASH_PATH/$filename"; then
      mv "$filename" "$TRASH_PATH/$filename $(date +"%T")"
    else
      mv "$filename" "$TRASH_PATH/$filename"
    fi
  done
}

restore() {
  for filename in "$@"; do
    mv "$TRASH_PATH/$filename" "$filename"
  done
}

help() {
  printf "
  -- [files]           Move files to bin
  -h                   Help
  -e                   Empty bin
  -l                   Check list of the files in bin
  -r [files]           Restore files from bin
  "
}

while getopts "r:ehl" option; do
  case "$option" in
  e) rm -rf "$TRASH_PATH" && mkdir "$TRASH_PATH" ;;
  h) help ;;
  l) ls "$TRASH_PATH" ;;
  r) shift && restore "$@" ;;
  :) echo "Option -$OPTARG requires argument." ;;
  *) ;;
  esac
done

if [ $OPTIND == 1 ]; then
  if [ $# == 0 ]; then
    echo "No arguments specified"
    exit 1
  fi

  delete "$@"
fi
