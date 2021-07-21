#!/usr/bin/env bash
export LC_ALL=en_US.UTF-8

scripts="$HOME/.tmux/plugins/tmux-cpu/scripts"
set -g @ram_percentage_format "%5.1f%%"

echo "$($scripts/ram_percentage.sh)"

