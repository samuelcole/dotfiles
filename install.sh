#!/bin/sh

git submodule update --init

for name in *; do
  target="$HOME/.$name"
  if [ ! -e "$target" ]; then
    if [ "$name" != 'install.sh' ] && [ "$name" != 'README.md' ]; then
      echo "Creating $target"
      ln -s "$PWD/$name" "$target"
    fi
  else
    echo "$target exists!"
  fi
done
