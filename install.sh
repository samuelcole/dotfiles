#!/bin/sh

for name in *; do
  target="$HOME/.$name"
  if [ ! -e "$target" ]; then
    if [ "$name" != 'install.sh' ]; then
      echo "Creating $target"
      ln -s "$PWD/$name" "$target"
    fi
  else
    echo "$target exists!"
  fi
done
