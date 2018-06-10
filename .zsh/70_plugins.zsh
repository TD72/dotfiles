#!/bin/zsh

# b4b4r07/emoji-cli
export EMOJI_CLI_FILTER=$INTERACTIVE_FILTER
export EMOJI_CLI_KEYBIND="^_"


# b4b4r07/enhancd
export ENHANCD_FILTER=$INTERACTIVE_FILTER
export ENHANCD_COMMAND=cd
export ENHANCD_DOT_SHOW_FULLPATH=1
export ENHANCD_DISABLE_DOT=0
export ENHANCD_DISABLE_HYPHEN=0
export ENHANCD_DISABLE_HOME=1
export ENHANCD_HOOK_AFTER_CD="ls"

# b4b4r07/zsh-history
export ZSH_HISTORY_FILE="$XDG_CACHE_HOME/zsh_history.db"
export ZSH_HISTORY_KEYBIND_GET_BY_DIR="^r"
export ZSH_HISTORY_KEYBIND_GET_ALL="^r^a"
export ZSH_HISTORY_KEYBIND_SCREEN="^r^r"
export ZSH_HISTORY_KEYBIND_ARROW_UP="^p"
export ZSH_HISTORY_KEYBIND_ARROW_DOWN="^n"

# marzocchi/zsh-notify
zstyle ':notify:*' error-title
zstyle ':notify:*' success-title
zstyle ':notify:*' command-complete-timeout 15

# vim:set fenc=utf-8 ff=unix expandtab sw=4 ts=4:
