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
double=$(option "@nova-double" true)

#
# double
#

if [ $double = "true" ]; then
  tmux set-option -g status 2
fi

#
# themes
#

theme=$(option "@nova-theme" "nord")

if [ $theme = "dracula" ]; then
  tmux set-option -g "@nova-pane-active-border-style" "#44475a"
  tmux set-option -g "@nova-pane-border-style" "#282a36"
  tmux set-option -g "@nova-plugins-mode-colors" "#8be9fd #282a36"
  tmux set-option -g "@nova-plugins-whoami-colors" "#bd93f9 #282a36"
  tmux set-option -g "@nova-status-style-bg" "#44475a"
  tmux set-option -g "@nova-status-style-fg" "#f8f8f2"
  tmux set-option -g "@nova-status-style-active-bg" "#6272a4"
  tmux set-option -g "@nova-status-style-active-fg" "#f8f8f2"
  tmux set-option -g "@nova-status-style-double-bg" "#282a36"
  tmux set-option -g "@nova-plugins-spotify-colors" "#282a36 #f8f8f2"
  tmux set-option -g "@nova-plugins-cpu-colors" "#282a36 #f8f8f2"
  tmux set-option -g "@nova-plugins-gpu-colors" "#282a36 #f8f8f2"
fi

if [ $theme = "nord" ]; then
  tmux set-option -g "@nova-pane-active-border-style" "#44475a"
  tmux set-option -g "@nova-pane-border-style" "#282a36"
  tmux set-option -g "@nova-plugins-mode-colors" "#88c0d0 #2e3440"
  tmux set-option -g "@nova-plugins-whoami-colors" "#81a1c1 #2e3440"
  tmux set-option -g "@nova-status-style-bg" "#4c566a"
  tmux set-option -g "@nova-status-style-fg" "#d8dee9"
  tmux set-option -g "@nova-status-style-active-bg" "#5e81ac"
  tmux set-option -g "@nova-status-style-active-fg" "#d8dee9"
  tmux set-option -g "@nova-status-style-double-bg" "#2e3440"
  tmux set-option -g "@nova-plugins-spotify-colors" "#2e3440 #d8dee9"
  tmux set-option -g "@nova-plugins-cpu-colors" "#2e3440 #d8dee9"
  tmux set-option -g "@nova-plugins-gpu-colors" "#2e3440 #d8dee9"
fi

#
# status-interval
#

status_interval=$(option "@nova-status-interval" 5)
tmux set-option -g status-interval $status_interval

#
# status-style
#

status_style_bg=$(option "@nova-status-style-bg")
status_style_fg=$(option "@nova-status-style-fg")
status_style_active_bg=$(option "@nova-status-style-active-bg")
status_style_active_fg=$(option "@nova-status-style-active-fg")
tmux set-option -g status-style "bg=$status_style_bg,fg=$status_style_fg"

#
# pane
#

pane_border_style=$(option "@nova-pane-border-style")
pane_active_border_style=$(option "@nova-pane-active-border-style")
tmux set-option -g pane-border-style "fg=${pane_border_style}"
tmux set-option -g pane-active-border-style "fg=${pane_active_border_style}"

#
# status-left
#

status_left_plugins=$(option "@nova-status-left-plugins" "mode whoami")
IFS=' ' read -r -a status_left_plugins <<< $status_left_plugins

tmux set-option -g status-left-length 100
tmux set-option -g status-left ""

for plugin in "${status_left_plugins[@]}"; do
  if [ -f "$current_dir/$plugin.sh" ]; then

    plugin_colors=$(option "@nova-plugins-$plugin-colors")
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
  tmux set-window-option -g window-status-current-format "#[fg=${status_style_bg},bg=${status_style_active_bg}]"
  tmux set-window-option -ga window-status-current-format "$powerline_left"
fi

tmux set-window-option -g window-status-format "#[fg=$status_style_fg]#[bg=$status_style_bg]"
tmux set-window-option -ga window-status-format "$(padding $padding)"
tmux set-window-option -ga window-status-format "#S:#I:#W"
tmux set-window-option -ga window-status-format "$(padding $padding)"

if [ $powerline = true ]; then
  tmux set-window-option -ga window-status-current-format "#[fg=${status_style_active_fg}]#[bg=${status_style_active_bg}]"
else
  tmux set-window-option -g window-status-current-format "#[fg=${status_style_active_fg}]#[bg=${status_style_active_bg}]"
fi

tmux set-window-option -ga window-status-current-format "$(padding $padding)"
tmux set-window-option -ga window-status-current-format "#S:#I:#W"
tmux set-window-option -ga window-status-current-format "$(padding $padding)"

if [ $powerline = true ]; then
  tmux set-window-option -ga window-status-current-format "#[fg=${status_style_active_bg},bg=${status_style_bg}]"
  tmux set-window-option -ga window-status-current-format "$powerline_left"
fi


#
# status-right
#

status_right_plugins=$(option "@nova-status-right-plugins" "")
IFS=' ' read -r -a status_right_plugins <<< $status_right_plugins

tmux set-option -g status-right-length 100
tmux set-option -g status-right ""


for plugin in "${status_right_plugins[@]}"; do
  if [ -f "$current_dir/$plugin.sh" ]; then

    plugin_colors=$(option "@nova-plugins-$plugin-colors")
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

#
# status-bottom-left
#

status_style_double_bg=$(option "@nova-status-style-double-bg")
status_bottom_left_plugins=$(option "@nova-status-bottom-left-plugins" "spotify")
IFS=' ' read -r -a status_bottom_left_plugins <<< $status_bottom_left_plugins

tmux set-option -g status-format[1] "#[fill=$status_style_double_bg]#[align=left]"
powerline_color="$status_style_double_bg"

for plugin in "${status_bottom_left_plugins[@]}"; do
  if [ -f "$current_dir/$plugin.sh" ]; then

    plugin_colors=$(option "@nova-plugins-$plugin-colors")
    IFS=' ' read -r -a plugin_colors <<< $plugin_colors

    if [ $powerline = true ] && [ "$(tmux show-option -gqv status-format[1])" != "#[align=left]"]; then
      tmux set-option -ga status-format[1] "#[fg=${powerline_color},bg=#${plugin_colors[0]}]"
      tmux set-option -ga status-format[1] "$powerline_left"
    fi

    tmux set-option -ga status-format[1] "#[fg=${plugin_colors[1]},bg=${plugin_colors[0]}]"
    tmux set-option -ga status-format[1] "$(padding $padding)"
    tmux set-option -ga status-format[1] "#($current_dir/$plugin.sh)"
    tmux set-option -ga status-format[1] "$(padding $padding)"

    [ $powerline = true ] && powerline_color="${plugin_colors[0]}"
  fi
done

if [ $powerline = true ] && [ ! -z $powerline_color ]; then
  tmux set-option -ga status-format[1] "#[fg=${powerline_color},bg=${status_style_double_bg}]"
  tmux set-option -ga status-format[1] "$powerline_left"
fi


#
# status-bottom-right
#

powerline_color="$status_style_double_bg"

status_bottom_right_plugins=$(option "@nova-status-bottom-plugins" "cpu gpu")
IFS=' ' read -r -a status_bottom_right_plugins <<< $status_bottom_right_plugins

tmux set-option -ga status-format[1] "#[align=right]"

for plugin in "${status_bottom_right_plugins[@]}"; do
  if [ -f "$current_dir/$plugin.sh" ]; then

    plugin_colors=$(option "@nova-plugins-$plugin-colors")
    IFS=' ' read -r -a plugin_colors <<< $plugin_colors

    if [ $powerline = true ]; then
      tmux set-option -ga status-format[1] "#[fg=${plugin_colors[0]},bg=#${powerline_color}]"
      tmux set-option -ga status-format[1] "$powerline_right"
    fi

    tmux set-option -ga status-format[1] "#[fg=${plugin_colors[1]},bg=${plugin_colors[0]}]"
    tmux set-option -ga status-format[1] "$(padding $padding)"
    tmux set-option -ga status-format[1] "#($current_dir/$plugin.sh)"
    tmux set-option -ga status-format[1] "$(padding $padding)"

    [ $powerline = true ] && powerline_color="${plugin_colors[0]}"
  fi
done

