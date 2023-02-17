#!/usr/bin/env bash
export LC_ALL=en_US.UTF-8

get_option() {
  local option=$(tmux show-option -gqv "$1")
  [ -z $option ] && echo $2 || echo $option
}

set_option() {
  tmux set-option -g "$1" "$2"
}

upsert_option() {
  local option=$(get_option "$1" "$2")
  tmux set-option -g "$1" "$option"
}

padding() {
  printf '%*s' $1
}
