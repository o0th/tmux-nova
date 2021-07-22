#!/usr/bin/env bash
export LC_ALL=en_US.UTF-8

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $current_dir/utils.sh

labels=$(get_option "@nova-plugins-mode-labels" "ω Ω")
IFS=' ' read -r -a labels <<< $labels

echo "#{?client_prefix,${labels[1]},${labels[0]}}"

