#! /bin/zsh
#
# Check whether the vital file is loaded
if ! vitalize 2>/dev/null; then
    echo "cannot run as shell script" 1>&2
    return 1
fi

# Vim-like keybind as default
bindkey -v
# Vim-like escaping jj keybind
bindkey -M viins 'jj' vi-cmd-mode

# Add emacs-like keybind to viins mode
bindkey -M viins '^F'    forward-char
bindkey -M viins '^B'    backward-char
bindkey -M viins '^P'    up-line-or-history
bindkey -M viins '^N'    down-line-or-history
bindkey -M viins '^A'    beginning-of-line
bindkey -M viins '^E'    end-of-line
bindkey -M viins '^K'    kill-line
bindkey -M viins '^R'    history-incremental-pattern-search-backward
bindkey -M viins '\er'   history-incremental-pattern-search-forward
bindkey -M viins '^Y'    yank
bindkey -M viins '^W'    backward-kill-word
bindkey -M viins '^U'    backward-kill-line
bindkey -M viins '^H'    backward-delete-char
bindkey -M viins '^?'    backward-delete-char
bindkey -M viins '^G'    send-break
bindkey -M viins '^D'    delete-char-or-list

bindkey -M vicmd '^A'    beginning-of-line
bindkey -M vicmd '^E'    end-of-line
bindkey -M vicmd '^K'    kill-line
# bindkey -M vicmd '^P'    up-line-or-history
# bindkey -M vicmd '^N'    down-line-or-history
bindkey -M vicmd '^Y'    yank
bindkey -M vicmd '^W'    backward-kill-word
bindkey -M vicmd '^U'    backward-kill-line
bindkey -M vicmd '/'     vi-history-search-forward
bindkey -M vicmd '?'     vi-history-search-backward

# Original keybind
#
bindkey -M vicmd 'gg' beginning-of-line
bindkey -M vicmd 'G'  end-of-line


# bind P and N keys
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# Insert a last word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey -M viins '^]' insert-last-word

# Surround a forward word by single quote
quote-previous-word-in-single() {
    modify-current-argument '${(qq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N quote-previous-word-in-single
bindkey -M viins '^Q' quote-previous-word-in-single

# Surround a forward word by double quote
quote-previous-word-in-double() {
    modify-current-argument '${(qqq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N quote-previous-word-in-double
bindkey -M viins '^Xq' quote-previous-word-in-double

bindkey -M viins "$terminfo[kcbt]" reverse-menu-complete

#bindkey -s 'vv' "!vi\n"
#bindkey -s ':q' "^A^Kexit\n"


#=================================
# functions
#=================================
do-enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return
    fi

    echo
    if is_git_repo; then
        git status
    else
        ls
    fi

    zle reset-prompt
}
zle -N do-enter
bindkey '^m' do-enter
# commandline edit using vim
zle -N edit-command-line
bindkey '^x^x' edit-command-line
