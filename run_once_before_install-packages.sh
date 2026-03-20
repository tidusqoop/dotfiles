#!/bin/bash

# 서드파티 tap
brew tap laishulu/homebrew

# CLI 도구
brew install \
    argocd \
    bat \
    delta \
    direnv \
    eza \
    fd \
    fzf \
    go \
    golangci-lint \
    helm \
    htop \
    jq \
    k9s \
    kubectl \
    kustomize \
    lazygit \
    macism \
    markdownlint-cli2 \
    neovim \
    ripgrep \
    sheldon \
    starship \
    tmux \
    tmuxinator \
    tree \
    yazi \
    yq \
    zoxide

# neovim 의존성
brew install \
    luarocks \
    tree-sitter \
    tree-sitter-cli

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
