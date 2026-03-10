#!/bin/bash

# CLI 도구
brew install \
    bat \
    delta \
    direnv \
    fd \
    fzf \
    htop \
    jq \
    ripgrep \
    sheldon \
    starship \
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

# GUI 앱
brew install --cask \
    ghostty
