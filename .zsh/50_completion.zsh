#!/bin/zsh
#
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

