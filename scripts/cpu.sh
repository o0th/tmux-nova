#!/usr/bin/env bash
export LC_ALL=en_US.UTF-8

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $current_dir/utils.sh

scripts="$HOME/.tmux/plugins/tmux-cpu/scripts"
tmux set-option -g @cpu_percentage_format "%5.1f%%"
tmux set-option -g @ram_percentage_format "%5.1f%%"

cpu_temp=$(echo "$($scripts/cpu_temp.sh)" | sed -r 's/[C]+//g')

if [[ $cpu_temp -ge 0 ]] && [[ $cpu_temp -le 24 ]]; then
  cpu_thermometer=""
elif [[ $cpu_temp -ge 25 ]] && [[ $cpu_temp -le 49 ]]; then
  cpu_thermometer=""
elif [[ $cpu_temp -ge 50 ]] && [[ $cpu_temp -le 74 ]]; then
  cpu_thermometer=""
elif [[ $cpu_temp -ge 75 ]] && [[ $cpu_temp -le 99 ]]; then
  cpu_thermometer=""
else
  cpu_thermometer=""
fi

nerdfonts=$(option "@nova-nerdfonts" false)

if [ "$nerdfonts" = true ]; then
  echo "$($scripts/cpu_percentage.sh)  $($scripts/ram_percentage.sh)     $cpu_temp 糖$cpu_thermometer"
else
  echo "$($scripts/cpu_percentage.sh) CPU $($scripts/ram_percentage.sh) RAM    $cpu_temp C"
fi

