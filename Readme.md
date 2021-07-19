<p align="center">
  <a>
    <img src="/assets/screenshot.png" alt="screenshot">
  </a>
</p>

### Installation

Using [tpm](https://github.com/tmux-plugins/tpm)

```bash
set -g @plugin 'o0th/tmux-nova'
```

<kbd>Prefix</kbd> + <kbd>I</kbd>

### Customization

Themes

```bash
# one of: "dracula", "nord"; default: "dracula"
set -g @nova-theme "dracula"
```

Justify

```bash
# one of: "left", "right", "centre"; default: "left"
set -g @nova-status-justify "left"
```

Plugins

```bash
# list from: "mode", "whoami", "spotify"; default: "mode whoami", "spotify"
set -g @nova-status-left-plugins "mode whoami"
set -g @nova-status-right-plugins "spotify"
```

