#!/usr/bin/env bash
# Symlinks every file/dir tracked here into $HOME.
# Run after cloning: ./install.sh
# Safe to re-run: skips existing symlinks, warns on conflicts.

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

link() {
  local src="$DOTFILES_DIR/$1"
  local dst="$HOME/$1"

  if [[ -L "$dst" ]]; then
    echo "  skip  $dst (already a symlink)"
    return
  fi

  if [[ -e "$dst" ]]; then
    mkdir -p "$BACKUP_DIR"
    mv "$dst" "$BACKUP_DIR/"
    echo "  backup $dst -> $BACKUP_DIR/$1"
  fi

  ln -s "$src" "$dst"
  echo "  link  $dst -> $src"
}

echo "==> Installing dotfiles from $DOTFILES_DIR"

# Add entries here as you track new files, e.g.:
#   link .zshrc
#   link .gitconfig
#   link .claude

# Claude Code config
[[ -d "$DOTFILES_DIR/.claude" ]] && link .claude

echo "==> Done."
