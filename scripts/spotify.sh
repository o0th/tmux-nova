#!/usr/bin/env bash
export LC_ALL=en_US.UTF-8

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $current_dir/utils.sh

nerdfonts=$(option "@nova-nerdfonts" false)

if [ "$nerdfonts" = true ]; then
  echo "$(spotifycli --playbackstatus) $(spotifycli --status)"
else
  echo "$(spotifycli --status)"
fi

