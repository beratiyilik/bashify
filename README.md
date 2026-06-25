# bashify

**A Minimalist Powerlevel10k-Inspired Bash Prompt**

Lightweight, modular, and lightning-fast — `bashify` captures the spirit of Oh My
Zsh's [Powerlevel10k](https://github.com/romkatv/powerlevel10k) while staying true
to Bash's simplicity. Designed for developers who want a visually clear, Git-aware,
and extensible `PS1` without the bloat.

```
~/r/b/bashify  main  +1 ~2 ?3  *1                              & node 22.14 $ v5.2  09:01 AM
> 
```

## Features

- **Git-integrated prompt** — branch, staged/modified/untracked counts, stashes,
  merge conflicts, and ahead/behind remote tracking
- **Customizable path formats** — `full`, `compact`, `compactalt`, `shortened`, `name`
- **Right-aligned segments** — Node.js version, background jobs, Bash version, time
- **256-color support** via xterm ANSI escape sequences
- **Fully modular** — reorder, enable, or disable segments via simple arrays
- **No dependencies** — pure Bash; `git`, `jq`, and `npx` are used only when present
- **Fast** — single-pass `git status --porcelain`, no per-prompt subshell storms

## Requirements

- **Bash 4+** (uses `read -ra`, `mapfile`-style loops, associative-friendly syntax)
- `git` — optional, enables the git segment
- `jq` — optional, improves Node.js `engines.node` parsing (falls back to `grep`)
- A terminal with 256-color and Nerd Font / Powerline glyph support for the icons

## Installation

### One-line install

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/beratiyilik/bashify/HEAD/install.sh)"
```

The `HEAD` in the URL always fetches the latest installer. It then installs the
**latest stable release tag** when one exists, and falls back to the default
branch (`main`) until the first release is tagged. There is no commit/branch
pinning by design — to install from a mirror or fork, override the source repo
with `BASHIFY_REPO`.

The installer clones bashify into `~/.bashify` and appends a `source` line to your
`~/.bashrc`. Restart your shell or run `source ~/.bashrc` to apply.

The installer also seeds a starter config at
`~/.config/bashify/bashifyrc` (it won't overwrite an existing one).

Override the install location, rc file, or source repo with environment variables:

```bash
BASHIFY_DIR=~/.local/share/bashify RC_FILE=~/.bash_profile \
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/beratiyilik/bashify/HEAD/install.sh)"
```

| Variable       | Default                              | Purpose                               |
| -------------- | ------------------------------------ | ------------------------------------- |
| `BASHIFY_DIR`  | `~/.bashify`                         | install location for the remote fetch |
| `RC_FILE`      | `~/.bashrc`                          | rc file to append the `source` line   |
| `BASHIFY_REPO` | `github.com/beratiyilik/bashify.git` | source repo to clone (mirror/fork)    |

### From a clone

```bash
git clone https://github.com/beratiyilik/bashify.git ~/.bashify
~/.bashify/install.sh
```

### Manual install

Source the script from your `~/.bashrc` (or `~/.bash_profile`):

```bash
source /path/to/bashify.bash
```

## Configuration

All defaults can be overridden in `~/.config/bashify/bashifyrc`, which is sourced
automatically if present. bashify resolves the config in this order:

1. an explicit `BASHIFY_USER_CONFIG` (point it anywhere you like)
2. `${XDG_CONFIG_HOME:-~/.config}/bashify/bashifyrc` — the standard location
3. `~/.bashifyrc` — the legacy dotfile, still honored for backward compatibility

Create the file and set only the values you want to change — the `BASHIFY_FG_*`
palette and `BASHIFY_STYLE_*` attributes are available inside it. For example:

```bash
# ~/.config/bashify/bashifyrc
BASHIFY_DIR_STYLE="compact"
BASHIFY_PROMPT_CHAR_ICON="❯"
BASHIFY_RIGHT_PROMPT_ELEMENTS=(node time)
```

### Segments

Control which segments appear and in what order:

```bash
# left side (next to the cursor)
BASHIFY_LEFT_PROMPT_ELEMENTS=(
  # user        # username
  # hostname    # short hostname
  dir           # current directory
  git           # branch and status
  prompt_char   # prompt character (> )
  status        # non-zero exit code of last command
)

# right side (right-aligned)
BASHIFY_RIGHT_PROMPT_ELEMENTS=(
  jobs          # background job count
  node          # Node.js version when in a node project
  bashver       # bash version
  time          # current time
)

# disable the right side entirely (auto-off in Docker / dumb terminals)
BASHIFY_RIGHT_PROMPT_ENABLED=true

# nudge right-aligned segments left/right; can be negative, zero, or positive
BASHIFY_RIGHT_PROMPT_OFFSET=0
```

### Directory styles

Set `BASHIFY_DIR_STYLE` to one of:

| Style        | Example (`~/repos/beratiyilik/bashify`) |
| ------------ | --------------------------------------- |
| `full`       | `~/repos/beratiyilik/bashify`           |
| `compact`    | `~/r/b/bashify`                         |
| `compactalt` | `~/rep/ber/bashify` (default)           |
| `shortened`  | `~/.../beratiyilik/bashify`             |
| `name`       | `bashify`                               |

```bash
BASHIFY_DIR_STYLE="compactalt"
BASHIFY_DIR_MAX_LENGTH=30        # threshold for the shortened style
BASHIFY_DIR_MAX_COMPONENTS=4     # threshold for the shortened style
BASHIFY_DIR_COMPACT_MIN_LEN=3    # min chars kept per segment in compactalt
```

### Git

```bash
BASHIFY_GIT_SHOW_DIRTY=true
BASHIFY_GIT_SHOW_AHEAD_BEHIND=true
BASHIFY_GIT_CACHE_TIMEOUT=3
```

Status icons (defaults): `+` staged, `~` unstaged, `?` untracked, `x` conflict,
`*` stash, `^` ahead, `v` behind, `` clean.

### Colors and icons

Every segment exposes `*_COLOR` and `*_ICON` variables (e.g.
`BASHIFY_GIT_COLOR_BRANCH`, `BASHIFY_PROMPT_CHAR_ICON`). Colors use the predefined
`BASHIFY_FG_*` palette or any raw ANSI escape. See `bashify.bash` for the full
list — every option is documented inline.

## Project layout

```
bashify/
├── bashify.bash              # the prompt engine — source this
├── install.sh                # appends the source line to ~/.bashrc
├── README.md
└── LICENSE
```

## License

See [LICENSE](LICENSE).
