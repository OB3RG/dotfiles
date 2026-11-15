# Dotfiles

My personal configuration files for a Fedora development environment, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

Each top-level directory is a stow package. The internal structure mirrors the target path from `$HOME`.

| Package | Target | Description |
|---|---|---|
| `gitconfig/` | `~/.gitconfig` | Git configuration |
| `zsh/` | `~/.zshrc`, `~/.zsh/` | Zsh shell configuration |
| `nvim/` | `~/.config/nvim/` | Neovim editor |
| `tmux/` | `~/.config/tmux/` | Terminal multiplexer |
| `alacritty/` | `~/.config/alacritty/` | Alacritty terminal (Gruvbox Dark) |
| `ssh/` | `~/.ssh/config` | SSH configuration |
| `scripts/` | `~/.local/bin/` | Utility scripts |
| `pi-agent/` | `~/.pi/agent/` | Agent definitions, memory workflow, prompts, and JABFA MCP wrapper |

## Installation

### Fresh Fedora machine

Fedora's installer handles the base system and your desktop (GNOME or KDE
Plasma). Then follow [`install/README.md`](install/README.md) — in short:

```bash
git clone https://github.com/OB3RG/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh            # stows everything, sets zsh as login shell
./install/packages.sh   # dev packages via dnf
```

### What install.sh does

1. Installs GNU stow if not present
2. Clones the repo to `~/.dotfiles` (when run standalone)
3. Initializes git submodules (zsh plugins)
4. Stows all packages (idempotent via `--restow`)
5. Enables the GNOME Keyring SSH agent when available (Fedora Workstation)
6. Changes the login shell to zsh

### Manual setup

```bash
# Install stow
sudo dnf install stow

# Clone and stow
git clone git@github.com:OB3RG/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git submodule update --init --recursive
stow gitconfig zsh nvim tmux alacritty ssh scripts pi-agent
```

## Pi agents and memory

The `pi-agent` package mirrors the user-level Pi agent configuration into `~/.pi/agent/`:

- Ten reviewed agent definitions, including `brain-recall` and `brain-scribe`
- Global memory instructions, the `llm-memory` skill, and recall/remember prompts
- `bin/jabfa-brain-mcp.sh`, which incrementally indexes the brain and starts its local MCP server

Install with `stow --restow pi-agent`. JABFA is built separately with `cargo build --release --bins` in its repository. Register the server once with:

```bash
pi mcp add jabfa --exposure direct --description 'Local read-only JABFA recall over the llm-brain vault' -- ~/.pi/agent/bin/jabfa-brain-mcp.sh
```

The wrapper defaults to `$HOME/Work/jabfa`, `$HOME/Documents/llm-brain`, and `${XDG_RUNTIME_DIR:-/tmp}/llm-brain-jabfa.sqlite3`. Override them with `JABFA_ROOT`, `BRAIN_VAULT`, `JABFA_DATABASE`, or `JABFA_BIN` when needed.

No authentication files, provider model stores, sessions, or MCP service configuration are packaged. In particular, `auth.json`, `models-store.json`, `sessions/`, and `mcp.json` are deliberately excluded; configure MCP services locally.

## Terminal themes

**Alacritty (KDE):** the `alacritty` package configures Gruvbox Dark to match
Neovim, with live config reload enabled. Edit
`~/.config/alacritty/alacritty.toml`; changes apply without restarting.

**Ptyxis (GNOME):** `~/.local/bin/ptyxis-theme.sh` selects its bundled
**Gruvbox** palette so the terminal matches Neovim's colorscheme (it follows
the GNOME dark/light style automatically).

Scripts use Ptyxis by default on GNOME and Alacritty on KDE. Set `TERMINAL` in
`~/.zshrc.local` to override that choice.

## Machine-Specific Configuration

No branches needed. Each config sources a `.local` file if it exists (gitignored):

- `~/.zshrc.local` — machine-specific zsh overrides
- `~/.gitconfig.local` — machine-specific git settings (email, etc.)

Example `~/.gitconfig.local`:
```ini
[user]
    email = your-email@example.com
```

Example `~/.zshrc.local`:
```zsh
export PATH=$PATH:/some/machine/specific/path
```

## Work Configuration

Work configs live in a separate private repository:

```bash
git clone git@github.com:OB3RG/dotfiles-work.git ~/.dotfiles-work
cd ~/.dotfiles-work
stow .
```

The work repo contains:
- `~/.gitconfig-work` — work email, credential helper (includes personal gitconfig)
- `~/.zshrc.local` — work PATH, work aliases
- `~/.ssh/config.d/` — work SSH hosts

## Notable

- No credentials or API keys are stored in this public repository
- No large binaries — install scripts in `~/.local/bin/` handle downloads (sops is not packaged for Fedora)
- Zsh plugins are managed as git submodules, not vendored
