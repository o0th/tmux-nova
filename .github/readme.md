<p align="center">
  <a>
    <img src="assets/screenshot.png" alt="screenshot">
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

Add this line in your `.tmux.conf`

```bash
run-shell ~/.tmux/plugins/tmux-nova/nova.tmux
```

Reload TMUX

```bash
tmux source-file ~/.tmux.conf
```

## Customizations

### No configuration

<p align="center">
  <a>
    <img src="assets/tmux-nova-no-conf.png" alt="screenshot">
  </a>
</p>

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

<p align="center">
  <a><img src="assets/tmux-nova-pane.png" alt="screenshot"></a>
</p>

```bash
# default: "#S:#I:#W"
set -g @nova-pane "#I#{?pane_in_mode,  #{pane_mode},}  #W"
```

Pane position

<p align="center">
  <a><img src="assets/tmux-nova-pane-centre.png" alt="screenshot"></a>
</p>

```bash
# one of: "left", "right", "centre", "absolute-centre"; default: "left"
set -g @nova-pane-justify "centre"
```

### Segments

Create a custom segment

<p align="center">
  <a><img src="assets/tmux-nova-segment-custom.png" alt="screenshot"></a>
</p>

```bash
# this will create a new segment named 'custom'
set -g @nova-segment-custom "custom"
set -g @nova-segment-custom-colors "#50fa7b #282a36"

# this will position the custom segment on the right side
set -g @nova-segments-0-left ""
set -g @nova-segments-0-right "custom"
```

Mode segment

<p align="center">
  <a><img src="assets/tmux-nova-segment-mode.png" alt="screenshot"></a>
</p>

```bash
set -g @nova-segment-mode "#{?client_prefix,Ω,ω}"
set -g @nova-segment-mode-colors "#50fa7b #282a36"
set -g @nova-segments-0-left "mode"
set -g @nova-segments-0-right ""
```

Whoami segment

```bash
set -g @nova-segment-whoami "#(whoami)@#h"
set -g @nova-segment-whoami-colors "#50fa7b #282a36"
set -g @nova-segments-0-right "whoami"
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

### Gallery

For more example have a look at the have a look at the [gallery](gallery.md).

