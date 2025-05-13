#!/usr/bin/env bash

set -e

echo "🔧 Setting up dotfiles for Nathan Oyewole..."

# --- Essentials ---
PKGS=(git zsh curl wget neovim tmux)

echo "📦 Installing packages..."
sudo apt update && sudo apt install -y "${PKGS[@]}"

# --- Symlinks ---
echo "🔗 Creating symlinks..."

ln -sf "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
ln -sf "$HOME/.dotfiles/.tmux.conf" "$HOME/.tmux.conf"

mkdir -p "$HOME/.config/nvim"
ln -sf "$HOME/.dotfiles/nvim/init.lua" "$HOME/.config/nvim/init.lua"

# --- Zsh Plugins ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "🎩 Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# --- TPM (Tmux Plugin Manager) ---
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "📦 Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# --- Lazy.nvim ---
if [ ! -d "$HOME/.local/share/nvim/site/pack/lazy" ]; then
  echo "⚙️ Installing lazy.nvim..."
  git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/site/pack/lazy/start/lazy.nvim
fi

# --- Change Default Shell to Zsh ---
if [ "$SHELL" != "/usr/bin/zsh" ]; then
  echo "💻 Changing default shell to Zsh..."
  chsh -s "$(which zsh)"
fi

echo "✅ Dotfiles setup complete!"

