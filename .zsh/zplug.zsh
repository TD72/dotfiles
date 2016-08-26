#!/bin/zsh

has_plugin() {
    (( $+functions[zplug] )) || return 1
    zplug check "${1:?too few arguments}"
    return $status
}


# local loading
zplug "b4b4r07/zplug"

# local plugins
zplug "~/.zsh", \
    from:local, \
    nice:2, \
    use:"<->_*.zsh"

# Original Prompt
zplug "TD72/powerline-shell"


# commands
zplug "so-fancy/diff-so-fancy", \
    as:command, \
    use:diff-so-fancy

zplug "peco/peco", \
   as:command, \
   from:gh-r, \
   frozen:1

zplug "b4b4r07/dotfiles", \
    as:command, \
    use:bin/peco-tmux

zplug "b4b4r07/dotfiles", \
    as:command, \
    use:bin/tmuxx

zplug "b4b4r07/dotfiles", \
    as:command, \
    use:bin/richpager

zplug "simonwhitaker/gibo", \
    as:command, \
    use:gibo, \
    nice:15

zplug "simonwhitaker/gibo", \
    as:plugin, \
    use:gibo-completion.zsh, \
    nice:14

# plugins
zplug "glidenote/hub-zsh-completion"

zplug "b4b4r07/zsh-vimode-visual", \
    use:"*.sh"

zplug "zsh-users/zsh-completions"

zplug "zsh-users/zsh-history-substring-search"

zplug "zsh-users/zsh-syntax-highlighting", \
    nice:19

zplug "plugins/git", \
    from:oh-my-zsh

zplug "mollifier/anyframe"


# zplug "junegunn/fzf-bin", \
#     as:command, \
#     from:gh-r, \
#     file:"fzf", \
#     frozen:1
#

# zplug "b4b4r07/enhancd", \
#     use:enhancd.sh
