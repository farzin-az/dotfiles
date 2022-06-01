#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run nm-applet
run picom --experimental-backends
run tor
run clipit
run element-desktop --hidden
python /home/farzin/Code/scripts/feh.py
