#! /bin/zsh

if [[ -f $HOME/.path ]]; then
    source $HOME/.path
else
    export DOTPATH="${0:A:t}"
fi

$DOTPATH/.bin/tmuxx


# Vim-like keybind as default
bindkey -v
# Vim-like escaping jj keybind{{{
#bindkey -M viins 'jj' vi-cmd-mode

# Add emacs-like keybind to viins mode
bindkey -M viins '^F'    forward-char
bindkey -M viins '^B'    backward-char
bindkey -M viins '^P'    up-line-or-history
bindkey -M viins '^N'    down-line-or-history
bindkey -M viins '^A'    beginning-of-line
bindkey -M viins '^E'    end-of-line
bindkey -M viins '^K'    kill-line
#bindkey -M viins '^R'    history-incremental-pattern-search-backward
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
# }}}

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

function replace_multiple_dots() {
  local dots=$LBUFFER[-2,-1]
  if [[ $dots == ".." ]]; then
    LBUFFER=$LBUFFER[1,-3]'../.'
  fi
  zle self-insert
}

zle -N replace_multiple_dots
bindkey "." replace_multiple_dots

#---------------------------------------------
# Powerline
#---------------------------------------------
function powerline_precmd() {
    PS1="$(powerline-go -error -$? -shell zsh -newline -east-asian-width -modules venv,host,ssh,cwd,perms,git,hg,jobs,exit,root)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
  install_powerline_precmd
fi

#---------------------------------------------
# Filter
#---------------------------------------------
zstyle ':chpwd:*' recent-dirs-file "$XDG_CACHE_HOME/zsh/chpwd-recent-dirs"
function cdr-fzy {
  local path=$(cdr -l | awk '{ print $2 }' | fzy)
  if [ -n "$path" ]; then
        BUFFER="eval cd ${(q)path}"
        zle accept-line
  fi
  zle clear-screen
}
zle -N cdr-fzy
bindkey '^xj' cdr-fzy


function kill-peco {
  ps ax | peco | awk '{ print $1 }' | xargs kill -9
}
zle -N kill-peco
bindkey '^xk' kill-peco

function under-cd-dir {
  find . -type d -not -iwholename "*/.git/*" \
    | fzy \
    | cd
}
zle -N under-cd-dir
alias cdd=under-cd-dir
# bindkey '^\.' under-cd-dir

alias gibol='gibo -l | sed "/=/d" | tr "\t", "\n" | sed "/^$/d" | sort | fzy | xargs gibo'

alias -g P='`docker ps | tail -n +2 | peco | cut -d" " -f1`'
alias -g I='`docker images --format "table {{.ID}}\t{{.Repository}}\t{{.CreatedSince}}\t{{.Size}}" | peco | cut -d" " -f1`'


function rg-edit {
    local path=$(rg --line-number $* | peco | awk -F: '{printf  $1 " +" $2}'| sed -e 's/\+$//')
    if [ -n "$path" ]; then
        echo "$EDITOR $path"
        eval $EDITOR $path
    fi
}
zle -N rg-edit
alias rge='rg-edit'


#---------------------------------------------
# Completion
#---------------------------------------------
setopt no_beep
# ディレクトリ名のみの入力で移動
# setopt auto_cd
# cdpath=(.. ~ ~/src)
# ディレクトリの移動履歴を記録
setopt auto_pushd
# スペルの訂正
setopt correct
setopt magic_equal_subst

### Complement ###
setopt auto_list
setopt auto_menu
setopt list_packed
setopt list_types

### History ###
setopt bang_hist
# set execute time in history
setopt extended_history
setopt hist_ignore_dups
setopt share_history
setopt hist_reduce_blanks
setopt inc_append_history
setopt magic_equal_subst
setopt extended_glob
setopt globdots
setopt extended_glob

zstyle ':completion:*default' menu select=2
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list \
  'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
zstyle ':completion:*' verbose yes
# zstyle ':completion:*' \
  # completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
zstyle ':completion:*:warnings' \
  format $RED'No matches for:'$YELLOW' %d'$DEFAULT
zstyle ':completion:*:descriptions' \
  format $YELLOW'completing %B%d%b'$DEFAULT
zstyle ':completion:*:corrections' \
  format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
# グループ名に空文字を指定すると，マッチ対象のタグ名がグループ名に使われる。
# したがって，すべての マッチ種別を別々に表示させたいなら以下のようにする
# zstyle ':completion:*' group-name ''

# カレントディレクトリに候補がない場合のみ cdpath 上のディレクトリを候補に出す
# zstyle ':completion:*:cd:*' tag-order local-directories path-directories

#ファイル補完候補に色を付ける
if [ -n "%LS_COLORS" ]; then
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

zstyle ':completion:*' use-cache true

zstyle ':completion:*' list-separator '-->'

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
compctl -K _pip_completion pip3
# pip zsh completion end


#=================================
# misc source
#=================================
# Default Python Interpretor
. $HOME/.virtualenvs/default/bin/activate

# direnv
if (( $+commands[direnv] )); then
    eval "$(direnv hook zsh)"
fi

export NVIM_SOCKETS_DIR=$XDG_CACHE_HOME/nvimsockets
mkdir -p $NVIM_SOCKETS_DIR

vimr() {
    NVIM_LISTEN_ADDRESS=$NVIM_SOCKETS_DIR/$1 vim ${@:2}
}

nvcd() {
    nvr -c "cd `pwd`"
}


#=================================
# Plugins
#=================================
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


#=================================
# pac source
#=================================
for f in $XDG_CACHE_HOME/pac/etc/zsh/src/*.zsh; do
  source $f
done

if (which zprof > /dev/null 2>&1); then
  zprof
fi

