#!/bin/bash

# tpm으로 tmux 플러그인 설치 (tmux.conf 배포 후 실행)
if [ -x "$HOME/.config/tmux/plugins/tpm/bin/install_plugins" ]; then
    "$HOME/.config/tmux/plugins/tpm/bin/install_plugins"
fi
