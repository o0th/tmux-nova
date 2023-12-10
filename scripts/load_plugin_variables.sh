#!/usr/bin/env bash
export LC_ALL=en_US.UTF-8

tmux set-option -g status-left ""

tmux set-environment -g @nova-load-variables ""
all=""

for var in "$@"
do
    tmux set-option -ga status-left "#{$var}*"
    all+="$var "
done
tmux set-environment -g @nova-load-variables "$all"
