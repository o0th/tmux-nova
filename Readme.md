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

### Themes

```bash
# one of: "dracula", "nord"; default: "dracula"
set -g @nova-theme "dracula"
```


### Rows

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

```bash
# default: "#S:#I:#W"
set -g @nova-pane "#I#{?pane_in_mode,  #{pane_mode},}  #W"
```

### Pane justify

```bash
# one of: "left", "right", "centre", "absolute-centre"; default: "left"
set -g @nova-pane-justify "left"
```

### Segments

```bash
set -g @nova-rows 0
set -g @nova-segments-0-left "mode"
set -g @nova-segments-0-right "whoami"
```

Multiple status bar

```bash
set -g @nova-rows 1
set -g @nova-segments-0-left "mode"
set -g @nova-segments-0-right "whoami"
set -g @nova-segments-1-right "spotify"
set -g @nova-segments-1-left "net"
```

### Custom segments

Define a custom segment using a cli (e.g.: [spotify-cli-liunx](https://github.com/pwittchen/spotify-cli-linux))

```bash
set -g @nova-segment-spotify "#(spotifycli --playbackstatus) #(spotifycli --status)"
set -g @nova-segment-spotify-colors "#282a36 #f8f8f2"

set -g @nova-segments-1-left "spotify"
```

Example with [tmux-cpu](https://github.com/tmux-plugins/tmux-cpu)

```bash
set -g @plugin 'tmux-plugins/tmux-cpu'

set -g @cpu_percentage_format "%5.1f%%"
set -g @cpu_temp_format "%3.0f"
set -g @cpu_temp_unit "C"
set -g @nova-segment-cpu "CPU #(~/.tmux/plugins/tmux-cpu/scripts/cpu_percentage.sh) #(~/.tmux/plugins/tmux-cpu/scripts/cpu_temp.sh)"
set -g @nova-segment-cpu-colors "#282a36 #f8f8f2"

set -g @ram_percentage_format "%5.1f%%"
set -g @nova-segment-ram "RAM #(~/.tmux/plugins/tmux-cpu/scripts/ram_percentage.sh)"
set -g @nova-segment-ram-colors "#282a36 #f8f8f2"

set -g @gpu_percentage_format "%5.1f%%"
set -g @gpu_temp_format "%3.0f"
set -g @gpu_temp_unit "C"
set -g @nova-segment-gpu "GPU #(~/.tmux/plugins/tmux-cpu/scripts/gpu_percentage.sh) #(~/.tmux/plugins/tmux-cpu/scripts/gpu_temp.sh)"
set -g @nova-segment-gpu-colors "#282a36 #f8f8f2"

set -g @gram_percentage_format "%5.1f%%"
set -g @nova-segment-gram "GRAM #(~/.tmux/plugins/tmux-cpu/scripts/gram_percentage.sh)"
set -g @nova-segment-gram-colors "#282a36 #f8f8f2"

set -g @nova-segments-1-right "cpu ram gpu gram"
```

Example with [tmux-net-speed](https://github.com/tmux-plugins/tmux-net-speed)

```bash
set -g @net_speed_interfaces "enp6s0"
set -g @net_speed_format "↓ %10s - ↑ %10s"
set -g @nova-segment-net "#(~/.tmux/plugins/tmux-net-speed/scripts/net_speed.sh)"
set -g @nova-segment-net-colors "#282a36 #f8f8f2"

set -g @nova-segments-2-left "net"
```
