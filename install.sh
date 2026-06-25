#!/usr/bin/env bash
#
# bashify installer
#
# Local checkout:
#   ./install.sh                   # install from this checkout
#   ./install.sh ~/.bash_profile   # target a different rc file
#
# Remote (Oh My Zsh style):
#   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/beratiyilik/bashify/main/install.sh)"
#
# Environment overrides:
#   BASHIFY_DIR   install location when fetched remotely   (default: ~/.bashify)
#   RC_FILE       rc file to modify                        (default: ~/.bashrc)
#   BASHIFY_REPO  git repo to clone                        (default: GitHub)

set -euo pipefail

BASHIFY_REPO="${BASHIFY_REPO:-https://github.com/beratiyilik/bashify.git}"
BASHIFY_RAW="${BASHIFY_RAW:-https://raw.githubusercontent.com/beratiyilik/bashify/main}"
INSTALL_DIR="${BASHIFY_DIR:-$HOME/.bashify}"
RC_FILE="${RC_FILE:-${1:-$HOME/.bashrc}}"
MARKER="# bashify prompt"

# user config lives under the XDG config home (preferred over a ~/.bashifyrc dotfile)
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/bashify"
CONFIG_FILE="$CONFIG_DIR/bashifyrc"
LEGACY_CONFIG="$HOME/.bashifyrc"

# resolve the directory this script lives in, tolerating `curl | bash` where
# BASH_SOURCE points at /dev/fd/* or is unset
SCRIPT_DIR=""
if [[ -n "${BASH_SOURCE[0]:-}" && -f "${BASH_SOURCE[0]}" ]]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

# decide where bashify.bash will be sourced from
if [[ -n "$SCRIPT_DIR" && -f "$SCRIPT_DIR/bashify.bash" ]]; then
  # running from a local checkout — use it in place
  BASHIFY_HOME="$SCRIPT_DIR"
else
  # running remotely — fetch into INSTALL_DIR
  echo "Fetching bashify into $INSTALL_DIR ..."
  if command -v git &>/dev/null; then
    if [[ -d "$INSTALL_DIR/.git" ]]; then
      git -C "$INSTALL_DIR" pull --ff-only
    else
      git clone --depth 1 "$BASHIFY_REPO" "$INSTALL_DIR"
    fi
  elif command -v curl &>/dev/null; then
    mkdir -p "$INSTALL_DIR"
    curl -fsSL "$BASHIFY_RAW/bashify.bash" -o "$INSTALL_DIR/bashify.bash"
  else
    echo "error: need either git or curl to install remotely" >&2
    exit 1
  fi
  BASHIFY_HOME="$INSTALL_DIR"
fi

BASHIFY_PATH="$BASHIFY_HOME/bashify.bash"
SOURCE_LINE="source \"$BASHIFY_PATH\""

if [[ ! -f "$BASHIFY_PATH" ]]; then
  echo "error: bashify.bash not found at $BASHIFY_PATH" >&2
  exit 1
fi

# bail out cleanly if it is already installed
if [[ -f "$RC_FILE" ]] && grep -qF "$BASHIFY_PATH" "$RC_FILE"; then
  echo "bashify is already sourced in $RC_FILE — nothing to do."
  exit 0
fi

{
  printf '\n%s\n' "$MARKER"
  printf '%s\n' "$SOURCE_LINE"
} >>"$RC_FILE"

echo "Installed bashify into $RC_FILE"
echo "Run 'source $RC_FILE' or restart your shell to apply."
echo

# seed a starter config at the XDG location, but never clobber an existing one
# (XDG or legacy). bashify.bash reads whichever is present at runtime.
if [[ -f "$CONFIG_FILE" ]]; then
  echo "Config already present at $CONFIG_FILE — left untouched."
elif [[ -f "$LEGACY_CONFIG" ]]; then
  echo "Found legacy config at $LEGACY_CONFIG — it will keep working."
  echo "To adopt the standard location, move it to $CONFIG_FILE."
elif [[ -f "$BASHIFY_HOME/.bashifyrc.example" ]]; then
  mkdir -p "$CONFIG_DIR"
  cp "$BASHIFY_HOME/.bashifyrc.example" "$CONFIG_FILE"
  echo "Created a starter config at $CONFIG_FILE — edit it to customize."
else
  echo "Optional: create $CONFIG_FILE to override defaults (see the README)."
fi
