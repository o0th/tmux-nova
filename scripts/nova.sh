#!/usr/bin/env bash
export LC_ALL=en_US.UTF-8

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $current_dir/utils.sh

#
# global options
#

padding=$(option "@nova-padding" 1)
powerline=$(option "@nova-powerline" true)
powerline_right=$(option "@nova-powerline-right" )
powerline_left=$(option "@nova-powerline-left" )

#
# status-interval
#

status_interval=$(option "@nova-status-interval" 5)
tmux set-option -g status-interval $status_interval

#
# status-style
#

status_style_bg=$(option "@nova-status-style-bg" "#44475a")
status_style_fg=$(option "@nova-status-style-fg" "#f8f8f2")
tmux set-option -g status-style "bg=$status_style_bg,fg=$status_style_fg"

#
# pane
#

tmux set-option -g pane-active-border-style "fg=#44475a"
tmux set-option -g pane-border-style "fg=#282a36"

#
# status-left
#

status_left_plugins=$(option "@nova-status-left-plugins" "mode whoami")
IFS=' ' read -r -a status_left_plugins <<< $status_left_plugins

tmux set-option -g status-left-length 100
tmux set-option -g status-left ""

for plugin in "${status_left_plugins[@]}"; do
  if [ -f "$current_dir/$plugin.sh" ]; then

    plugin_colors=$(option "@nova-plugins-$plugin-colors" "#50fa7b #333")
    IFS=' ' read -r -a plugin_colors <<< $plugin_colors

    if [ $powerline = true ] && [ -n "$(tmux show-option -gqv status-left)" ]; then
      tmux set-option -ga status-left "#[fg=${powerline_color},bg=#${plugin_colors[0]}]"
      tmux set-option -ga status-left "$powerline_left"
    fi

    tmux set-option -ga status-left "#[fg=${plugin_colors[1]},bg=${plugin_colors[0]}]"
    tmux set-option -ga status-left "$(padding $padding)"
    tmux set-option -ga status-left "#($current_dir/$plugin.sh)"
    tmux set-option -ga status-left "$(padding $padding)"

    [ $powerline = true ] && powerline_color="${plugin_colors[0]}"
  fi
done

if [ $powerline = true ] && [ ! -z $powerline_color ]; then
  tmux set-option -ga status-left "#[fg=${powerline_color},bg=${status_style_bg}]"
  tmux set-option -ga status-left "$powerline_left"
fi


#
# status
#

status_justify=$(option "@nova-status-justify" "left")
tmux set-option status-justify ${status_justify}

#
# status-format
#

if [ $powerline = true ]; then
  tmux set-window-option -g window-status-current-format "#[fg=${status_style_bg},bg=#282a36]"
  tmux set-window-option -ga window-status-current-format "$powerline_left"
fi

tmux set-window-option -g window-status-format "#[fg=$status_style_fg]#[bg=$status_style_bg]"
tmux set-window-option -ga window-status-format "$(padding $padding)"
tmux set-window-option -ga window-status-format "#S:#I:#W"
tmux set-window-option -ga window-status-format "$(padding $padding)"

if [ $powerline = true ]; then
  tmux set-window-option -ga window-status-current-format "#[fg=#f8f8f2]#[bg=#282a36]"
else
  tmux set-window-option -g window-status-current-format "#[fg=#f8f8f2]#[bg=#282a36]"
fi

tmux set-window-option -ga window-status-current-format "$(padding $padding)"
tmux set-window-option -ga window-status-current-format "#S:#I:#W"
tmux set-window-option -ga window-status-current-format "$(padding $padding)"

if [ $powerline = true ]; then
  tmux set-window-option -ga window-status-current-format "#[fg=${status_style_bg},bg=#282a36]"
  tmux set-window-option -ga window-status-current-format "$powerline_right"
fi


#
# status-right
#

status_right_plugins=$(option "@nova-status-right-plugins" "spotify")
IFS=' ' read -r -a status_right_plugins <<< $status_right_plugins

tmux set-option -g status-right-length 100
tmux set-option -g status-right ""

for plugin in "${status_right_plugins[@]}"; do
  if [ -f "$current_dir/$plugin.sh" ]; then

    plugin_colors=$(option "@nova-plugins-$plugin-colors" "#50fa7b #333")
    IFS=' ' read -r -a plugin_colors <<< $plugin_colors

    if [ $powerline = true ] && [ ! -n "$(tmux show-option -gqv status-right)" ]; then
      tmux set-option -ga status-right "#[fg=${plugin_colors[0]},bg=#${status_style_bg}]"
      tmux set-option -ga status-right "$powerline_right"
    elif [ $powerline = true ] && [ -n "$(tmux show-option -gqv status-right)" ]; then
      tmux set-option -ga status-right "#[fg=${plugin_colors[0]},bg=#${powerline_color}]"
      tmux set-option -ga status-right "$powerline_right"
    fi

    tmux set-option -ga status-right "#[fg=${plugin_colors[1]},bg=${plugin_colors[0]}]"
    tmux set-option -ga status-right "$(padding $padding)"
    tmux set-option -ga status-right "#($current_dir/$plugin.sh)"
    tmux set-option -ga status-right "$(padding $padding)"

    [ $powerline = true ] && powerline_color="${plugin_colors[0]}"
  fi
done

