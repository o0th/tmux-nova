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
rows=$(get_option "@nova-rows" 0)
pane=$(get_option "@nova-pane" "#S:#I:#W")

#
# Default segments
#

upsert_option "@nova-segment-mode" "#{?client_prefix,Ω,ω}"
upsert_option "@nova-segment-whoami" "#(whoami)@#h"

#
# double
#

if [ "$rows" -eq 0 ]; then
  tmux set-option -g status on
else
  tmux set-option -g status $(expr $rows + 1)
fi

#
# interval
#

interval=$(get_option "@nova-interval" 5)
tmux set-option -g interval $interval

#
# UI style
#

message_command_style_bg=$(get_option "@nova-message-command-style-bg" "#44475a")
message_command_style_fg=$(get_option "@nova-message-command-style-fg" "#f8f8f2")
tmux set-option -g message-command-style "bg=$message_command_style_bg,fg=$message_command_style_fg"

message_style_bg=$(get_option "@nova-message-style-bg" "#282a36")
message_style_fg=$(get_option "@nova-message-style-fg" "#f8f8f2")
tmux set-option -g message-style "bg=$message_style_bg,fg=$message_style_fg"

mode_style_bg=$(get_option "@nova-mode-style-bg" "#44475a")
mode_style_fg=$(get_option "@nova-mode-style-fg" "#f8f8f2")
tmux set-option -g mode-style "bg=$mode_style_bg,fg=$mode_style_fg"

#
# status-style
#

status_style_bg=$(get_option "@nova-status-style-bg" "#44475a")
status_style_fg=$(get_option "@nova-status-style-fg" "#f8f8f2")
status_style_active_bg=$(get_option "@nova-status-style-active-bg" "#6272a4")
status_style_active_fg=$(get_option "@nova-status-style-active-fg" "#f8f8f2")
tmux set-option -g status-style "bg=$status_style_bg,fg=$status_style_fg"

#
# pane
#

pane_border_style=$(get_option "@nova-pane-border-style" "#282a36")
pane_active_border_style=$(get_option "@nova-pane-active-border-style" "#44475a")
tmux set-option -g pane-border-style "fg=${pane_border_style}"
tmux set-option -g pane-active-border-style "fg=${pane_active_border_style}"

#
# segments-0-left
#

segments_left=$(get_option "@nova-segments-0-left" "")
IFS=' ' read -r -a segments_left <<< $segments_left

tmux set-option -g status-left ""

first_left_segment=true
for segment in "${segments_left[@]}"; do
  segment_content=$(get_option "@nova-segment-$segment" "mode")
  segment_colors=$(get_option "@nova-segment-$segment-colors" "#282a36 #f8f8f2")
  IFS=' ' read -r -a segment_colors <<< $segment_colors
  if [ "$segment_content" != "" ]; then
    # condition everything on the non emptiness of the evaluated segment
    tmux set-option -ga status-left "#{?#{w:#{E:@nova-segment-$segment}},"

    if [ $nerdfonts = true ] && [ $first_left_segment = false ]; then
      tmux set-option -ga status-left "#[bg=${segment_colors[0]}]"
      tmux set-option -ga status-left "$nerdfonts_left"
    fi

    tmux set-option -ga status-left "#[fg=${segment_colors[1]}#,bg=${segment_colors[0]}]"
    tmux set-option -ga status-left "$(padding $padding)"
    tmux set-option -ga status-left "$segment_content"
    tmux set-option -ga status-left "$(padding $padding)"

    # set the fg color for the next nerdfonts seperator
    tmux set-option -ga status-left "#[fg=${segment_colors[0]}]"

    # condition end
    tmux set-option -ga status-left ',}'

    first_left_segment=false
  fi
done

if [ $nerdfonts = true ]; then
  tmux set-option -ga status-left "#[bg=${status_style_bg}]"
  tmux set-option -ga status-left "$nerdfonts_left"
fi

#
# status-format
#

pane_justify=$(get_option "@nova-pane-justify" "left")
tmux set-option -g status-justify ${pane_justify}

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
# segments-0-right
#

segments_right=$(get_option "@nova-segments-0-right" "")
IFS=' ' read -r -a segments_right <<< $segments_right

tmux set-option -g status-right ""

for segment in "${segments_right[@]}"; do
  segment_content=$(get_option "@nova-segment-$segment" "")
  segment_colors=$(get_option "@nova-segment-$segment-colors" "#282a36 #f8f8f2")
  IFS=' ' read -r -a segment_colors <<< $segment_colors
  if [ "$segment_content" != "" ] && [ "$segment_colors" != "" ]; then
    if [ $nerdfonts = true ] && [ ! -n "$(tmux show-option -gqv status-right)" ]; then
      tmux set-option -ga status-right "#[bg=#${status_style_bg}]"
    fi

    # condition everything on the non emptiness of the evaluated segment
    tmux set-option -ga status-right "#{?#{w:#{E:@nova-segment-$segment}},"

    if [ $nerdfonts = true ]; then
      tmux set-option -ga status-right "#[fg=${segment_colors[0]}]"
      tmux set-option -ga status-right "$nerdfonts_right"
    fi

    tmux set-option -ga status-right "#[fg=${segment_colors[1]}#,bg=${segment_colors[0]}]"
    tmux set-option -ga status-right "$(padding $padding)"
    tmux set-option -ga status-right "$segment_content"
    tmux set-option -ga status-right "$(padding $padding)"

    # set the bg color for the next nerdfonts seperator
    [ $nerdfonts = true ] && tmux set-option -ga status-right "#[bg=${segment_colors[0]}]"

    # condition end
    tmux set-option -ga status-right ',}'
  fi
done

for ((row=1; row <= rows; row++)); do

  #
  # segments-n-left
  #

  status_style_double_bg=$(get_option "@nova-status-style-double-bg" "#282a36")
  segments_bottom_left=$(get_option "@nova-segments-$row-left" "")
  IFS=' ' read -r -a segments_bottom_left <<< $segments_bottom_left

  tmux set-option -g status-format[$row] "#[fill=$status_style_double_bg]#[align=left]"
  nerdfonts_color="$status_style_double_bg"

  for segment in "${segments_bottom_left[@]}"; do
    segment_content=$(get_option "@nova-segment-$segment" "")
    segment_colors=$(get_option "@nova-segment-$segment-colors" "#282a36 #f8f8f2")
    IFS=' ' read -r -a segment_colors <<< $segment_colors
    if [ "$segment_content" != "" ]; then
      if [ $nerdfonts = true ] && [ "$(tmux show-option -gqv status-format[$row])" != "#[align=left]"]; then
        tmux set-option -ga status-format[$row] "#[fg=${nerdfonts_color},bg=#${segment_colors[0]}]"
        tmux set-option -ga status-format[$row] "$nerdfonts_left"
      fi

      tmux set-option -ga status-format[$row] "#[fg=${segment_colors[1]},bg=${segment_colors[0]}]"
      tmux set-option -ga status-format[$row] "$(padding $padding)"
      tmux set-option -ga status-format[$row] "$segment_content"
      tmux set-option -ga status-format[$row] "$(padding $padding)"

      [ $nerdfonts = true ] && nerdfonts_color="${segment_colors[0]}"
    fi
  done

  if [ $nerdfonts = true ] && [ ! -z $nerdfonts_color ]; then
    tmux set-option -ga status-format[$row] "#[fg=${nerdfonts_color},bg=${status_style_double_bg}]"
    tmux set-option -ga status-format[$row] "$nerdfonts_left"
  fi

  #
  # segments-n-center
  #

  nerdfonts_color="$status_style_double_bg"

  segments_bottom_center=$(get_option "@nova-segments-$row-center" "")
  IFS=' ' read -r -a segments_bottom_center <<< $segments_bottom_center

  tmux set-option -ga status-format[$row] "#[align=centre]"

  for segment in "${segments_bottom_center[@]}"; do
    segment_content=$(get_option "@nova-segment-$segment")
    segment_colors=$(get_option "@nova-segment-$segment-colors" "#282a36 #f8f8f2")
    IFS=' ' read -r -a segment_colors <<< $segment_colors

    if [ "$segment_content" != "" ]; then
      if [ $nerdfonts = true ]; then
        tmux set-option -ga status-format[$row] "#[fg=${nerdfonts_color},bg=#${segment_colors[0]}]"
        tmux set-option -ga status-format[$row] "$nerdfonts_left"
      fi

      tmux set-option -ga status-format[$row] "#[fg=${segment_colors[1]},bg=${segment_colors[0]}]"
      tmux set-option -ga status-format[$row] "$(padding $padding)"
      tmux set-option -ga status-format[$row] "$segment_content"
      tmux set-option -ga status-format[$row] "$(padding $padding)"

      if [ $nerdfonts = true ]; then
        tmux set-option -ga status-format[$row] "#[fg=${nerdfonts_color},bg=#${segment_colors[0]}]"
        tmux set-option -ga status-format[$row] "$nerdfonts_right"
      fi
    fi
  done

  #
  # segments-n-right
  #

  nerdfonts_color="$status_style_double_bg"

  segments_bottom_right=$(get_option "@nova-segments-$row-right" "")
  IFS=' ' read -r -a segments_bottom_right <<< $segments_bottom_right

  tmux set-option -ga status-format[$row] "#[align=right]"

  for segment in "${segments_bottom_right[@]}"; do
    segment_content=$(get_option "@nova-segment-$segment")
    segment_colors=$(get_option "@nova-segment-$segment-colors" "#282a36 #f8f8f2")
    IFS=' ' read -r -a segment_colors <<< $segment_colors

    if [ "$segment_content" != "" ]; then
      if [ $nerdfonts = true ]; then
        tmux set-option -ga status-format[$row] "#[fg=${segment_colors[0]},bg=#${nerdfonts_color}]"
        tmux set-option -ga status-format[$row] "$nerdfonts_right"
      fi

      tmux set-option -ga status-format[$row] "#[fg=${segment_colors[1]},bg=${segment_colors[0]}]"
      tmux set-option -ga status-format[$row] "$(padding $padding)"
      tmux set-option -ga status-format[$row] "$segment_content"
      tmux set-option -ga status-format[$row] "$(padding $padding)"
    fi
  done
done
