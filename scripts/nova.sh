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
double=$(get_option "@nova-double" false)
pane=$(get_option "@nova-pane" "#S:#I:#W")

#
# Default segments
#

upsert_option "@nova-segment-mode" "#{?client_prefix,Ω,ω}"
upsert_option "@nova-segment-whoami" "#(whoami)@#h"

#
# double
#

if [ $double = true ]; then
  tmux set-option -g status 2
fi

#
# themes
#

theme=$(get_option "@nova-theme" "dracula")

if [ $theme = "dracula" ]; then
  upsert_option "@nova-pane-active-border-style" "#44475a"
  upsert_option "@nova-pane-border-style" "#282a36"
  upsert_option "@nova-status-style-bg" "#44475a"
  upsert_option "@nova-status-style-fg" "#f8f8f2"
  upsert_option "@nova-status-style-active-bg" "#6272a4"
  upsert_option "@nova-status-style-active-fg" "#f8f8f2"
  upsert_option "@nova-status-style-double-bg" "#282a36"

  upsert_option "@nova-segment-mode-colors" "#50fa7b #282a36"
  upsert_option "@nova-segment-whoami-colors" "#50fa7b #282a36"
fi

if [ $theme = "nord" ]; then
  upsert_option "@nova-pane-active-border-style" "#44475a"
  upsert_option "@nova-pane-border-style" "#282a36"
  upsert_option "@nova-status-style-bg" "#4c566a"
  upsert_option "@nova-status-style-fg" "#d8dee9"
  upsert_option "@nova-status-style-active-bg" "#5e81ac"
  upsert_option "@nova-status-style-active-fg" "#d8dee9"
  upsert_option "@nova-status-style-double-bg" "#2e3440"

  upsert_option "@nova-segment-mode-colors" "#50fa7b #282a36"
  upsert_option "@nova-segment-whoami-colors" "#50fa7b #282a36"
fi

#
# interval
#

interval=$(get_option "@nova-interval" 5)
tmux set-option -g interval $interval

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
# segments-left
#

segments_left=$(get_option "@nova-segments-left" "mode")
IFS=' ' read -r -a segments_left <<< $segments_left

tmux set-option -g status-left ""

for segment in "${segments_left[@]}"; do
  segment_content=$(get_option "@nova-segment-$segment" "")
  segment_colors=$(get_option "@nova-segment-$segment-colors")
  IFS=' ' read -r -a segment_colors <<< $segment_colors
  if [ "$segment" != "" ] && [ "$segment_colors" != "" ]; then
    if [ $nerdfonts = true ] && [ -n "$(tmux show-option -gqv status-left)" ]; then
      tmux set-option -ga status-left "#[fg=${nerdfonts_color},bg=#${segment_colors[0]}]"
      tmux set-option -ga status-left "$nerdfonts_left"
    fi

    tmux set-option -ga status-left "#[fg=${segment_colors[1]},bg=${segment_colors[0]}]"
    tmux set-option -ga status-left "$(padding $padding)"
    tmux set-option -ga status-left "$segment_content"
    tmux set-option -ga status-left "$(padding $padding)"

    [ $nerdfonts = true ] && nerdfonts_color="${segment_colors[0]}"
  fi
done

if [ $nerdfonts = true ] && [ ! -z $nerdfonts_color ]; then
  tmux set-option -ga status-left "#[fg=${nerdfonts_color},bg=${status_style_bg}]"
  tmux set-option -ga status-left "$nerdfonts_left"
fi

#
# status-format
#

pane_justify=$(get_option "@nova-pane-justify" "left")
tmux set-option status-justify ${pane_justify}

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
# segments-right
#

segments_right=$(get_option "@nova-segments-right" "whoami")
IFS=' ' read -r -a segments_right <<< $segments_right

tmux set-option -g status-right ""

for segment in "${segments_right[@]}"; do
  segment_content=$(get_option "@nova-segment-$segment" "")
  segment_colors=$(get_option "@nova-segment-$segment-colors")
  IFS=' ' read -r -a segment_colors <<< $segment_colors
  if [ "$segment_content" != "" ] && [ "$segment_colors" != "" ]; then
    if [ $nerdfonts = true ] && [ ! -n "$(tmux show-option -gqv status-right)" ]; then
      tmux set-option -ga status-right "#[fg=${segment_colors[0]},bg=#${status_style_bg}]"
      tmux set-option -ga status-right "$nerdfonts_right"
    elif [ $nerdfonts = true ] && [ -n "$(tmux show-option -gqv status-right)" ]; then
      tmux set-option -ga status-right "#[fg=${segment_colors[0]},bg=#${nerdfonts_color}]"
      tmux set-option -ga status-right "$nerdfonts_right"
    fi

    tmux set-option -ga status-right "#[fg=${segment_colors[1]},bg=${segment_colors[0]}]"
    tmux set-option -ga status-right "$(padding $padding)"
    tmux set-option -ga status-right "$segment_content"
    tmux set-option -ga status-right "$(padding $padding)"

    [ $nerdfonts = true ] && nerdfonts_color="${segment_colors[0]}"
  fi
done

#
# segments-bottom-left
#

if [ $double = true ]; then
  status_style_double_bg=$(get_option "@nova-status-style-double-bg")
  segments_bottom_left=$(get_option "@nova-segments-bottom-left" "")
  IFS=' ' read -r -a segments_bottom_left <<< $segments_bottom_left

  tmux set-option -g status-format[1] "#[fill=$status_style_double_bg]#[align=left]"
  nerdfonts_color="$status_style_double_bg"

  for segment in "${segments_bottom_left[@]}"; do
    segment_content=$(get_option "@nova-segment-$segment" "")
    segment_colors=$(get_option "@nova-segment-$segment-colors")
    IFS=' ' read -r -a segment_colors <<< $segment_colors
    if [ "$segment_content" != "" ] && [ "$segment_colors" != "" ]; then
      if [ $nerdfonts = true ] && [ "$(tmux show-option -gqv status-format[1])" != "#[align=left]"]; then
        tmux set-option -ga status-format[1] "#[fg=${nerdfonts_color},bg=#${segment_colors[0]}]"
        tmux set-option -ga status-format[1] "$nerdfonts_left"
      fi

      tmux set-option -ga status-format[1] "#[fg=${segment_colors[1]},bg=${segment_colors[0]}]"
      tmux set-option -ga status-format[1] "$(padding $padding)"
      tmux set-option -ga status-format[1] "$segment_content"
      tmux set-option -ga status-format[1] "$(padding $padding)"

      [ $nerdfonts = true ] && nerdfonts_color="${segment_colors[0]}"
    fi
  done

  if [ $nerdfonts = true ] && [ ! -z $nerdfonts_color ]; then
    tmux set-option -ga status-format[1] "#[fg=${nerdfonts_color},bg=${status_style_double_bg}]"
    tmux set-option -ga status-format[1] "$nerdfonts_left"
  fi
fi

#
# segments-bottom-right
#

if [ $double = true ]; then
  nerdfonts_color="$status_style_double_bg"

  segments_bottom_right=$(get_option "@nova-segments-bottom-right" "")
  IFS=' ' read -r -a segments_bottom_right <<< $segments_bottom_right

  tmux set-option -ga status-format[1] "#[align=right]"

  for segment in "${segments_bottom_right[@]}"; do
    segment_content=$(get_option "@nova-segment-$segment" "")
    segment_colors=$(get_option "@nova-segment-$segment-colors")
    IFS=' ' read -r -a segment_colors <<< $segment_colors

    if [ "$segment" != "" ] && [ "$segment_colors" != "" ]; then
      if [ $nerdfonts = true ]; then
        tmux set-option -ga status-format[1] "#[fg=${segment_colors[0]},bg=#${nerdfonts_color}]"
        tmux set-option -ga status-format[1] "$nerdfonts_right"
      fi

      tmux set-option -ga status-format[1] "#[fg=${segment_colors[1]},bg=${segment_colors[0]}]"
      tmux set-option -ga status-format[1] "$(padding $padding)"
      tmux set-option -ga status-format[1] "$segment_content"
      tmux set-option -ga status-format[1] "$(padding $padding)"
    fi
  done
fi
