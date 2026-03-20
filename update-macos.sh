#!/bin/bash

set -e

function command_exists {
  type "$1" &> /dev/null
}

# Update brew and its casks
if command_exists brew; then
  brew update
  brew upgrade --greedy
  brew upgrade --cask --greedy
  brew cleanup -s && rm -rf $(brew --cache)
fi

if command_exists gpg; then
  # Restart the gpg agent because it was probably updated by brew
  killall gpg-agent && gpg-agent --daemon
fi

# Update Oh-My-Zsh
OHMYZSH_UPDATE_SCRIPT="$ZSH/tools/upgrade.sh"
if [ -f "$OHMYZSH_UPDATE_SCRIPT" ]; then
  sh $OHMYZSH_UPDATE_SCRIPT
fi

# Update Oh-My-Zsh custom plugins and themes
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
for plugin_dir in "$ZSH_CUSTOM/plugins"/*/; do
  if [ -d "$plugin_dir/.git" ]; then
    git -C "$plugin_dir" pull
  fi
done
for theme_dir in "$ZSH_CUSTOM/themes"/*/; do
  if [ -d "$theme_dir/.git" ]; then
    git -C "$theme_dir" pull
  fi
done

# Update global npm packages
if command_exists npm; then
  npm update -g -f
fi

# Update Ruby Gems (skip macOS system Ruby – no write permissions)
if command_exists gem && [ "$(which gem)" != "/usr/bin/gem" ]; then
  gem update
  gem cleanup
fi

# Update Rust toolchain
if command_exists rustup; then
  rustup update
fi

# Update Python tools via pipx
if command_exists pipx; then
  pipx upgrade-all
fi

# Update PHP Composer global packages
if command_exists composer && [ -f "$HOME/.composer/composer.json" ]; then
  composer global update
fi

# Update SDKMAN and its candidates
if [ -f "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk selfupdate
  sdk update
fi

# Update Mac App Store apps
if command_exists mas; then
  mas upgrade
fi

# Update tldr pages
if command_exists tldr; then
  tldr --update
fi

# Update Vim plugins (vim-plug)
if command_exists vim && [ -f "$HOME/.vim/autoload/plug.vim" ]; then
  vim +PlugUpdate +PlugClean! +qall
fi

# Update Neovim plugins (Lazy.nvim)
if command_exists nvim && [ -d "$HOME/.local/share/nvim/lazy" ]; then
  nvim --headless "+Lazy! sync" +qa
fi

# Update macOS
sudo softwareupdate -i -a

# Check for common brew issues
if command_exists brew; then
  brew doctor || true
fi
