#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

# Load vital library that is most important and
# constructed with many minimal functions
# For more information, see etc/README.md
. "$DOTPATH"/lib/vital.sh

# If you don't have Z shell or don't find vim preserved
# in a directory with the path,
# to install it after the platforms are detected

# Install vim
case "$(get_os)" in
    # Case of OS X
    osx)
        break
        ;;

    # Case of Linux
    linux)
        fc-cache -fv
        ;;

    # Other platforms such as BSD are supported
    *)
        log_fail "error: this script is only supported osx and linux"
        exit 1
        ;;
esac

# Run the forced termination with a last exit code
