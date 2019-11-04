eval (python -m virtualfish)

# 
# Aliases
#
alias servos="ssh root@redomar.co.uk"
alias m="~/Documents/mpv.app/Contents/MacOS/mpv"
alias config="/usr/local/bin/git --git-dir=$HOME/gitBareDotFiles --work-tree=$HOME"

# 
# Fish Variables
#

export CC="clang"
export CFLAGS="-fsanitize=signed-integer-overflow -fsanitize=undefined -O0 -std=c11 -Wall -Werror -Wextra -Wno-sign-compare -Wno-unused-parameter -Wno-unused-variable -Wshadow"
export LDLIBS="-lcs50 -lm"
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

set -g fish_user_paths "/usr/local/opt/sqlite/bin" $fish_user_paths

