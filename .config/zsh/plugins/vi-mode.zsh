# zsh-vi-mode 会覆盖其他插件（fzf 等）的键位，用官方 zvm_after_init 钩子抢回来。
function zvm_after_init() {
    bindkey -M viins '^R' fzf-history-widget                # fzf 历史搜索
    bindkey -M viins '^[r' atuin-search-viins               # atuin 历史搜索 (Alt-R)
    bindkey -M viins '^P' history-beginning-search-backward-end
    bindkey -M viins '^N' history-beginning-search-forward-end
    bindkey -M viins '^S' self-insert
    bindkey -M viins '^W' vi-backward-kill-word
}
