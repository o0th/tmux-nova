#!/usr/bin/env bash
export LC_ALL=en_US.UTF-8

option() {
  local option=$(tmux show-option -gqv "$1")
  [ -z $option ] && echo $2 || echo $option
}

padding() {
  printf '%*s' $1
}
