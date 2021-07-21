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

### Justify

```bash
# one of: "left", "right", "centre", "absolute-centre"; default: "left"
set -g @nova-status-justify "left"
```

### Double

```bash
# one of: true, false; default: true
set -g @nova-double true
```

### Plugins

```bash
# list from: "mode", "whoami", "spotify", "cpu", "gpu"
# default configuration:
set -g @nova-status-left-plugins "mode whoami"
set -g @nova-status-right-plugins ""
set -g @nova-status-bottom-left-plugins "spotify"
set -g @nova-status-bottom-right-plugins "cpu gpu"
```

#### mode

```bash
# Change colors background foreground
set -g @nova-plugins-mode-colors "#8be9fd #282a36"
```

#### whoami

```bash
# Change colors background foreground
set -g @nova-plugins-whoami-colors "#8be9fd #282a36"
```

#### spotify

Requirements: [pwittchen/spotify-cli-linux](https://github.com/pwittchen/spotify-cli-linux)

```bash
# Change colors background foreground
set -g @nova-plugins-cpu-colors "#282a36 #f8f8f2"
```

#### cpu

Requirements: [tmux-plugins/tmux-cpu](https://github.com/tmux-plugins/tmux-cpu)

```bash
# Change colors background foreground
set -g @nova-plugins-cpu-colors "#282a36 #f8f8f2"
```

#### gpu

Requirements: [tmux-plugins/tmux-cpu](https://github.com/tmux-plugins/tmux-cpu)

```bash
# Change colors background foreground
set -g @nova-plugins-cpu-colors "#282a36 #f8f8f2"
```

