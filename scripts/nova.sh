#!/usr/bin/env bash
export LC_ALL=en_US.UTF-8

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $current_dir/utils.sh

#
# global options
#

padding=$(get_option "@nova-padding" 1)
nerdfonts=$(get_option "@nova-nerdfonts" false)
nerdfonts_right=$(get_option "@nova-nerdfonts-right" )
nerdfonts_left=$(get_option "@nova-nerdfonts-left" )
double=$(get_option "@nova-double" true)
pane=$(get_option "@nova-pane" "#S:#I:#W")

#
# double
#

if [ $double = "true" ]; then
  tmux set-option -g status 2
fi

#
# themes
#

theme=$(get_option "@nova-theme" "dracula")

if [ $theme = "dracula" ]; then
  upsert_option "@nova-pane-active-border-style" "#44475a"
  upsert_option "@nova-pane-border-style" "#282a36"
  upsert_option "@nova-plugins-mode-colors" "#8be9fd #282a36"
  upsert_option "@nova-plugins-whoami-colors" "#bd93f9 #282a36"
  upsert_option "@nova-status-style-bg" "#44475a"
  upsert_option "@nova-status-style-fg" "#f8f8f2"
  upsert_option "@nova-status-style-active-bg" "#6272a4"
  upsert_option "@nova-status-style-active-fg" "#f8f8f2"
  upsert_option "@nova-status-style-double-bg" "#282a36"
  upsert_option "@nova-plugins-spotify-colors" "#282a36 #f8f8f2"
  upsert_option "@nova-plugins-cpu-colors" "#282a36 #f8f8f2"
  upsert_option "@nova-plugins-gpu-colors" "#282a36 #f8f8f2"
fi

if [ $theme = "nord" ]; then
  upsert_option "@nova-pane-active-border-style" "#44475a"
  upsert_option "@nova-pane-border-style" "#282a36"
  upsert_option "@nova-plugins-mode-colors" "#88c0d0 #2e3440"
  upsert_option "@nova-plugins-whoami-colors" "#81a1c1 #2e3440"
  upsert_option "@nova-status-style-bg" "#4c566a"
  upsert_option "@nova-status-style-fg" "#d8dee9"
  upsert_option "@nova-status-style-active-bg" "#5e81ac"
  upsert_option "@nova-status-style-active-fg" "#d8dee9"
  upsert_option "@nova-status-style-double-bg" "#2e3440"
  upsert_option "@nova-plugins-spotify-colors" "#2e3440 #d8dee9"
  upsert_option "@nova-plugins-cpu-colors" "#2e3440 #d8dee9"
  upsert_option "@nova-plugins-gpu-colors" "#2e3440 #d8dee9"
fi

#
# status-interval
#

status_interval=$(get_option "@nova-status-interval" 5)
tmux set-option -g status-interval $status_interval

#
# status-style
#

status_style_bg=$(get_option "@nova-status-style-bg")
status_style_fg=$(get_option "@nova-status-style-fg")
status_style_active_bg=$(get_option "@nova-status-style-active-bg")
status_style_active_fg=$(get_option "@nova-status-style-active-fg")
tmux set-option -g status-style "bg=$status_style_bg,fg=$status_style_fg"

#
# pane
#

pane_border_style=$(get_option "@nova-pane-border-style")
pane_active_border_style=$(get_option "@nova-pane-active-border-style")
tmux set-option -g pane-border-style "fg=${pane_border_style}"
tmux set-option -g pane-active-border-style "fg=${pane_active_border_style}"

#
# status-left
#

status_left_plugins=$(get_option "@nova-status-left-plugins" "mode whoami")
IFS=' ' read -r -a status_left_plugins <<< $status_left_plugins

tmux set-option -g status-left-length 100
tmux set-option -g status-left ""

for plugin in "${status_left_plugins[@]}"; do
  if [ -f "$current_dir/$plugin.sh" ]; then

    plugin_colors=$(get_option "@nova-plugins-$plugin-colors")
    IFS=' ' read -r -a plugin_colors <<< $plugin_colors

    if [ $nerdfonts = true ] && [ -n "$(tmux show-option -gqv status-left)" ]; then
      tmux set-option -ga status-left "#[fg=${nerdfonts_color},bg=#${plugin_colors[0]}]"
      tmux set-option -ga status-left "$nerdfonts_left"
    fi

    tmux set-option -ga status-left "#[fg=${plugin_colors[1]},bg=${plugin_colors[0]}]"
    tmux set-option -ga status-left "$(padding $padding)"
    tmux set-option -ga status-left "#($current_dir/$plugin.sh)"
    tmux set-option -ga status-left "$(padding $padding)"

    [ $nerdfonts = true ] && nerdfonts_color="${plugin_colors[0]}"
  fi
done

if [ $nerdfonts = true ] && [ ! -z $nerdfonts_color ]; then
  tmux set-option -ga status-left "#[fg=${nerdfonts_color},bg=${status_style_bg}]"
  tmux set-option -ga status-left "$nerdfonts_left"
fi

#
# status
#

status_justify=$(get_option "@nova-status-justify" "left")
tmux set-option status-justify ${status_justify}

#
# status-format
#

if [ $nerdfonts = true ]; then
  tmux set-window-option -g window-status-current-format "#[fg=${status_style_bg},bg=${status_style_active_bg}]"
  tmux set-window-option -ga window-status-current-format "$nerdfonts_left"
fi

tmux set-window-option -g window-status-format "#[fg=$status_style_fg]#[bg=$status_style_bg]"
tmux set-window-option -ga window-status-format "$(padding $padding)"
tmux set-window-option -ga window-status-format "$pane"
tmux set-window-option -ga window-status-format "$(padding $padding)"

if [ $nerdfonts = true ]; then
  tmux set-window-option -ga window-status-current-format "#[fg=${status_style_active_fg}]#[bg=${status_style_active_bg}]"
else
  tmux set-window-option -g window-status-current-format "#[fg=${status_style_active_fg}]#[bg=${status_style_active_bg}]"
fi

tmux set-window-option -ga window-status-current-format "$(padding $padding)"
tmux set-window-option -ga window-status-current-format "$pane"
tmux set-window-option -ga window-status-current-format "$(padding $padding)"

if [ $nerdfonts = true ]; then
  tmux set-window-option -ga window-status-current-format "#[fg=${status_style_active_bg},bg=${status_style_bg}]"
  tmux set-window-option -ga window-status-current-format "$nerdfonts_left"
fi

#
# status-right
#

status_right_plugins=$(get_option "@nova-status-right-plugins" "")
IFS=' ' read -r -a status_right_plugins <<< $status_right_plugins

tmux set-option -g status-right-length 100
tmux set-option -g status-right ""


for plugin in "${status_right_plugins[@]}"; do
  if [ -f "$current_dir/$plugin.sh" ]; then

    plugin_colors=$(get_option "@nova-plugins-$plugin-colors")
    IFS=' ' read -r -a plugin_colors <<< $plugin_colors

    if [ $nerdfonts = true ] && [ ! -n "$(tmux show-option -gqv status-right)" ]; then
      tmux set-option -ga status-right "#[fg=${plugin_colors[0]},bg=#${status_style_bg}]"
      tmux set-option -ga status-right "$nerdfonts_right"
    elif [ $nerdfonts = true ] && [ -n "$(tmux show-option -gqv status-right)" ]; then
      tmux set-option -ga status-right "#[fg=${plugin_colors[0]},bg=#${nerdfonts_color}]"
      tmux set-option -ga status-right "$nerdfonts_right"
    fi

    tmux set-option -ga status-right "#[fg=${plugin_colors[1]},bg=${plugin_colors[0]}]"
    tmux set-option -ga status-right "$(padding $padding)"
    tmux set-option -ga status-right "#($current_dir/$plugin.sh)"
    tmux set-option -ga status-right "$(padding $padding)"

    [ $nerdfonts = true ] && nerdfonts_color="${plugin_colors[0]}"
  fi
done

#
# status-bottom-left
#

status_style_double_bg=$(get_option "@nova-status-style-double-bg")
status_bottom_left_plugins=$(get_option "@nova-status-bottom-left-plugins" "spotify")
IFS=' ' read -r -a status_bottom_left_plugins <<< $status_bottom_left_plugins

tmux set-option -g status-format[1] "#[fill=$status_style_double_bg]#[align=left]"
nerdfonts_color="$status_style_double_bg"

for plugin in "${status_bottom_left_plugins[@]}"; do
  if [ -f "$current_dir/$plugin.sh" ]; then

    plugin_colors=$(get_option "@nova-plugins-$plugin-colors")
    IFS=' ' read -r -a plugin_colors <<< $plugin_colors

    if [ $nerdfonts = true ] && [ "$(tmux show-option -gqv status-format[1])" != "#[align=left]"]; then
      tmux set-option -ga status-format[1] "#[fg=${nerdfonts_color},bg=#${plugin_colors[0]}]"
      tmux set-option -ga status-format[1] "$nerdfonts_left"
    fi

    tmux set-option -ga status-format[1] "#[fg=${plugin_colors[1]},bg=${plugin_colors[0]}]"
    tmux set-option -ga status-format[1] "$(padding $padding)"
    tmux set-option -ga status-format[1] "#($current_dir/$plugin.sh)"
    tmux set-option -ga status-format[1] "$(padding $padding)"

    [ $nerdfonts = true ] && nerdfonts_color="${plugin_colors[0]}"
  fi
done

if [ $nerdfonts = true ] && [ ! -z $nerdfonts_color ]; then
  tmux set-option -ga status-format[1] "#[fg=${nerdfonts_color},bg=${status_style_double_bg}]"
  tmux set-option -ga status-format[1] "$nerdfonts_left"
fi


#
# status-bottom-right
#

nerdfonts_color="$status_style_double_bg"

status_bottom_right_plugins=$(get_option "@nova-status-bottom-plugins" "cpu gpu")
IFS=' ' read -r -a status_bottom_right_plugins <<< $status_bottom_right_plugins

tmux set-option -ga status-format[1] "#[align=right]"

for plugin in "${status_bottom_right_plugins[@]}"; do
  if [ -f "$current_dir/$plugin.sh" ]; then

    plugin_colors=$(get_option "@nova-plugins-$plugin-colors")
    IFS=' ' read -r -a plugin_colors <<< $plugin_colors

    if [ $nerdfonts = true ]; then
      tmux set-option -ga status-format[1] "#[fg=${plugin_colors[0]},bg=#${nerdfonts_color}]"
      tmux set-option -ga status-format[1] "$nerdfonts_right"
    fi

    tmux set-option -ga status-format[1] "#[fg=${plugin_colors[1]},bg=${plugin_colors[0]}]"
    tmux set-option -ga status-format[1] "$(padding $padding)"
    tmux set-option -ga status-format[1] "#($current_dir/$plugin.sh)"
    tmux set-option -ga status-format[1] "$(padding $padding)"

    [ $nerdfonts = true ] && nerdfonts_color="${plugin_colors[0]}"
  fi
done

