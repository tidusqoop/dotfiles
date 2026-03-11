#!/bin/bash

# CLI 도구
brew install \
    bat \
    delta \
    direnv \
    eza \
    fd \
    fzf \
    htop \
    jq \
    lazygit \
    ripgrep \
    sheldon \
    starship \
    tmux \
    tree \
    yazi \
    yq \
    zoxide

# yazi 미리보기 의존성
brew install \
    ffmpeg \
    poppler \
    sevenzip

# 폰트
brew install --cask \
    font-jetbrains-mono-nerd-font \
    font-noto-sans-cjk-kr

# tpm (tmux plugin manager)
if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
fi

# GUI 앱
brew install --cask \
    ghostty
