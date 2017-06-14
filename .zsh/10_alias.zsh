# cd
alias dot='cd $DOTPATH'
alias c='cd ~/'
alias b='cd $OLDPWD'

# ls
alias a='ls -a'
alias l='ls -l'
alias la='ls -la'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -r'

alias grep='grep --color'

alias tmux='tmux -2'

# neovim
alias vi='nvim'
alias vim='nvim'

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  alias vi='nvr'
  alias vim='nvr'
fi

# peco
# alias -g P='| peco'
alias peco='peco-tmux'

# git
alias gt='cd `git exec pwd`'
alias t='cd `git exec pwd`'

# latexmk
alias lmk='latexmk -pvc'
alias lmkc='latexmk -c'

if ! is_osx ; then
  alias docker='sudo docker'
fi

alias rp='richpager -s solarizeddark'

if ! is_linux ; then
  alias -s {png,jpg,bmp,PNG,JPG,BMP}=llpp
fi

# clipboard
# Mac
if which pbcopy >/dev/null 2>&1 ; then
    alias -g C='| pbcopy'
# Linux
elif which xsel >/dev/null 2>&1 ; then
    alias -g C='| xsel --input --clipboard'
# Cygwin
elif which putclip >/dev/null 2>&1 ; then
    alias -g C='| putclip'
fi

# ls_after cd: {{{1
chpwd() {
    ls_abbrev
}
ls_abbrev() {
    if [[ ! -r $PWD ]]; then
        return
    fi
    local cmd_ls='ls'

    local -a opt_ls
    opt_ls=('-GFC' '--color=always')

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS \
      command $cmd_ls ${opt_ls[@]} | sed $'/&^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')
    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}
# }}}

# w3m google search#{{{
google() {
    local str opt
    if [ $# != 0 ]; then
        for i in $*; do
            # $strが空じゃない場合、検索ワードを+記号でつなぐ(and検索)
            str="$str${str:++}$i"
        done
        opt='search?num=100'
        opt="${opt}&q=${str}"
    fi
    w3m http://www.google.co.jp/$opt
}#}}}

