#!/bin/bash

# Apply stow for all configurations
stow .

# Create symlink for zshrc
ln -sf ~/.config/zsh/zshrc ~/.zshrc
