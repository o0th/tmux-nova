<p align="center">
  <a>
    <img src="/assets/screenshot.png" alt="screenshot">
  </a>
</p>

### Installation


#### [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

Add this line in your `.tmux.conf`

```bash
set -g @plugin 'o0th/tmux-nova'
```

Hit <kbd>Prefix</kbd> + <kbd>I</kbd> to fetch the plugin and source it.

#### Manual

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

### Customizations

#### Themes

```bash
# one of: "dracula", "nord"; default: "dracula"
set -g @nova-theme "dracula"
```

#### Justify

```bash
# one of: "left", "right", "centre"; default: "left"
set -g @nova-status-justify "left"
```

#### Plugins

```bash
# list from: "mode", "whoami", "spotify"; default: "mode whoami", "spotify"
set -g @nova-status-left-plugins "mode whoami"
set -g @nova-status-right-plugins "spotify"
```

