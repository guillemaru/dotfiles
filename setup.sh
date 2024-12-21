#!/bin/bash

# Apply stow for all configurations
stow .

# Create symlink for files going in the home directory
ln -sf ~/.config/zsh/zshrc ~/.zshrc
ln -sf ~/.config/editorconfig/editorconfig ~/.editorconfig
