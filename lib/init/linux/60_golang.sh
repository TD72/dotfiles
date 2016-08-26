#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Load vital library that is most important and
# constructed with many minimal functions
# For more information, see etc/README.md
. "$DOTPATH"/lib/vital.sh

# If you don't have Z shell or don't find go preserved
# in a directory with the path,
# to install it after the platforms are detected
if ! has "go"; then

    # Install go
    case "$(get_os)" in
        # Case of OS X
        osx)
            if has "brew"; then
                log_echo "Install go with Homebrew"
                # brew install go
            elif "port"; then
                log_echo "Install go with MacPorts"
                # sudo port install go-devel
            else
                log_fail "error: require: Homebrew or MacPorts"
                exit 1
            fi
            ;;

        # Case of Linux
        linux)
            if has "emerge"; then
                log_echo "Install go "
                sudo emerge -v go
                go get github.com/motemen/ghq
            elif has "apt-get"; then
                log_echo "Install go "
                sudo apt-get -y install golang
                go get github.com/motemen/ghq
            elif has "yaourt"; then
                log_echo "Install go"
                sudo yaourt go
                go get github.com/motemen/ghq
            elif has "pacman"; then
                log_echo "Install go"
                sudo pacman -Sy go
                go get github.com/motemen/ghq
            else
                log_fail "error: require: YUM or APT"
                exit 1
            fi
            ;;

        # Other platforms such as BSD are supported
        *)
            log_fail "error: this script is only supported osx and linux"
            exit 1
            ;;
    esac
fi

# Run the forced termination with a last exit code
