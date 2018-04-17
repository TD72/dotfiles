#!/usr/local/bin/fish

if not functions -q fundle
    eval (curl -sfL https://git.io/fundle-install)
end

if not which powerline-go > /dev/null 2>&1
    go get -u github.com/td72/powerline-go
end

function fish_prompt
    powerline-go \
    -error $status \
    -shell bare \
    -newline \
    -east-asian-width \
    -modules venv,host,ssh,cwd,perms,git,hg,jobs,exit,root
end

function cd
    if test (count $argv) -eq 0
        return 0
    else if test (count $argv) -gt 1
        printf "%s\n" (_ "Too many args for cd command")
        return 1
    end
    # Avoid set completions.
    set -l previous $PWD

    if test "$argv" = "-"
        if test "$__fish_cd_direction" = "next"
            nextd
        else
            prevd
        end
        return $status
    end
    builtin cd $argv
    set -l cd_status $status
    # Log history
    if test $cd_status -eq 0 -a "$PWD" != "$previous"
        set -q dirprev[$MAX_DIR_HIST]
        and set -e dirprev[1]
        set -g dirprev $dirprev $previous
        set -e dirnext
        set -g __fish_cd_direction prev
    end

    if test $cd_status -ne 0
        return 1
    end
    ls
    return $status
end
