#!/bin/bash

cd "$(dirname "$0")"

function confirm_proceed {
  echo "This script will override any existing config you have. "
  read -p "Are you sure you want to proceed? " -r
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
      exit 1
  fi
}

function setup_atom {
  echo "Setting up Atom"

  command -v atom >/dev/null 2>&1 || { echo >&2 "Atom not found :("; exit 1; }

  echo "Symlinking Atom config"
  ln -sf `pwd`/atom/config.cson ~/.atom/config.cson
  ln -sf `pwd`/atom/keymap.cson ~/.atom/keymap.cson
  ln -sf `pwd`/atom/styles.less ~/.atom/styles.kess

  echo "Installing Atom packages"
  cd `pwd`/atom/
  source install-packages.sh
  cd ../
}

confirm_proceed
setup_atom
