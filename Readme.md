<p align="center">
  <a>
    <img src="/assets/screenshot.png" alt="screenshot">
  </a>
</p>

## Installation


### [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

Add this line in your `.tmux.conf`

```bash
set -g @plugin 'o0th/tmux-nova'
```

Hit <kbd>Prefix</kbd> + <kbd>I</kbd> to fetch the plugin and source it.

### Manual

Clone the repository

```bash
git clone git@github.com:o0th/tmux-nova.git ~/.tmux/plugins/tmux-nova
```

Add this line in your `.tmux.con`

```bash
run-shell ~/.tmux/plugins/tmux-nova/nova.tmux
```

Reload TMUX

```bash
tmux source-file ~/.tmux.conf
```

## Customizations

### Rows

Define how many status line to show.

```bash
# one of: 0, 1, 2, 3, 4; default: 0
set -g @nova-rows 0
```

### Nerdfonts

```bash
# one of: true, false; default: false
set -g @nova-nerdfonts false
```

### Pane

Pane content

```bash
# default: "#S:#I:#W"
set -g @nova-pane "#I#{?pane_in_mode,  #{pane_mode},}  #W"
```

Pane position

```bash
# one of: "left", "right", "centre", "absolute-centre"; default: "left"
set -g @nova-pane-justify "left"
```

### Segments

Mode segment

```bash
set -g @nova-segment-mode "#{?client_prefix,Ω,ω}"
set -g @nova-segment-mode-colors "#50fa7b #282a36"
set -g @nova-segments-0-left "mode"
```

Whoami segment

```bash
set -g @nova-segment-whoami "#(whoami)@#h"
set -g @nova-segment-whoami-colors "#50fa7b #282a36"
set -g @nova-segments-0-right "whoami"
```

[spotify-cli-linux](https://github.com/pwittchen/spotify-cli-linux) segment

```bash
set -g @nova-segment-spotify " #(spotifycli --status)"
set -g @nova-segment-spotify-colors "#282a36 #f8f8f2"

set -g @nova-segments-1-left "spotify"
```

[tmux-cpu](https://github.com/tmux-plugins/tmux-cpu) segment

```bash
set -g @plugin 'tmux-plugins/tmux-cpu'

set -g @cpu_percentage_format "%5.1f%%"
set -g @nova-segment-cpu "  #(~/.tmux/plugins/tmux-cpu/scripts/cpu_percentage.sh)"
set -g @nova-segment-cpu-colors "#282a36 #f8f8f2"

set -g @cpu_temp_unit "C"
set -g @cpu_temp_format "%3.0f"
set -g @nova-segment-cpu-temp "#(~/.tmux/plugins/tmux-cpu/scripts/cpu_temp.sh)"
set -g @nova-segment-cpu-temp-colors "#282a36 #f8f8f2"

set -g @ram_percentage_format "%5.1f%%"
set -g @nova-segment-ram "#(~/.tmux/plugins/tmux-cpu/scripts/ram_percentage.sh)"
set -g @nova-segment-ram-colors "#282a36 #f8f8f2"

set -g @gpu_percentage_format "%5.1f%%"
set -g @nova-segment-gpu "﬙  #(~/.tmux/plugins/tmux-cpu/scripts/gpu_percentage.sh)"
set -g @nova-segment-gpu-colors "#282a36 #f8f8f2"

set -g @gpu_temp_unit "C"
set -g @gpu_temp_format "%3.0f"
set -g @nova-segment-gpu-temp "#(~/.tmux/plugins/tmux-cpu/scripts/gpu_temp.sh)"
set -g @nova-segment-gpu-temp-colors "#282a36 #f8f8f2"

set -g @gram_percentage_format "%5.1f%%"
set -g @nova-segment-gram "#(~/.tmux/plugins/tmux-cpu/scripts/gram_percentage.sh)"
set -g @nova-segment-gram-colors "#282a36 #f8f8f2"

set -g @nova-segments-1-right "cpu ram cpu-temp gpu gram gpu-temp"
```

[tmux-net-speed](https://github.com/tmux-plugins/tmux-net-speed) segment

```bash
set -g @net_speed_interfaces "enp6s0"
set -g @net_speed_format "↓ %10s - ↑ %10s"
set -g @nova-segment-net "#(~/.tmux/plugins/tmux-net-speed/scripts/net_speed.sh)"
set -g @nova-segment-net-colors "#282a36 #f8f8f2"

set -g @nova-segments-2-left "net"
```

### Nord theme

```bash
set -g "@nova-pane-active-border-style" "#44475a"
set -g "@nova-pane-border-style" "#282a36"
set -g "@nova-status-style-bg" "#4c566a"
set -g "@nova-status-style-fg" "#d8dee9"
set -g "@nova-status-style-active-bg" "#89c0d0"
set -g "@nova-status-style-active-fg" "#2e3540"
set -g "@nova-status-style-double-bg" "#2d3540"

set -g @nova-segment-mode "#{?client_prefix,Ω,ω}"
set -g @nova-segment-mode-colors "#78a2c1 #2e3440"

set -g @nova-segment-whoami "#(whoami)@#h"
set -g @nova-segment-whoami-colors "#78a2c1 #2e3440"
```

