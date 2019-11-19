#eval (python -m virtualfish)

# 
# Aliases
#
alias servos="ssh root@redomar.co.uk"
alias m="~/Documents/mpv.app/Contents/MacOS/mpv"
alias config="/usr/local/bin/git --git-dir=$HOME/gitBareDotFiles --work-tree=$HOME"
alias vif="vim ~/.config/fish/config.fish"

# 
# Fish Variables
#

# CS50 VARIABLES
export CC="clang"
#export CFLAGS="-fsanitize=signed-integer-overflow -fsanitize=undefined -O0 -std=c11 -Wall -Werror -Wextra -Wno-sign-compare -Wno-unused-parameter -Wno-unused-variable -Wshadow"
#export CPPFLAGS="-I$(brew --prefix zlib)/include"
#export LDLIBS="-lcs50 -lm"

# PATHS
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
export PATH="/Users/Mohamed/Workspace/__.BIN:$PATH"

set -g fish_user_paths "/usr/local/opt/sqlite/bin" $fish_user_paths

# 
# NVM Functions
#

function find_up
    set path (pwd)
    while test $path != "/"
        and not test -e "$path/$argv[1]"
        set path (dirname $path)
    end
    if test -e "$path/$argv[1]"
        echo $path
    else
        echo ""
    end
end

function __check_nvm --on-variable PWD --description 'Detect node version'
  if test -f .nvmrc
    set node_version (nvm version)
    set nvmrc_node_version (nvm version (cat .nvmrc))

    if [ $nvmrc_node_version = "N/A" ]
      nvm install
    else if [ $nvmrc_node_version != $node_version ]
      nvm use
    end

    set -gx X_NVM_DIRTY_FLAG 1
  else if set -q X_NVM_DIRTY_FLAG; and [ (node --version) != (nvm version default) ]
    nvm use default
    set -e X_NVM_DIRTY_FLAG
  end
end

#function __check_nvm --on-variable PWD
#    if status --is-command-substitution
#        return
#    end
#
#    set nvm_path (find_up ".nvmrc" | tr -d '[:space:]')
#
#    if test "$nvm_path" != ""
#
#        set nvmrc_node_version (nvm version (cat "$nvm_path/.nvmrc") '; 2>1')
#
#        if test "$nvmrc_node_version" = "N/A"
#            echo "Installing node version "(cat "$nvm_path/.nvmrc")
#            nvm install
#            set nvm_node_version (nvm version)
#        else if test "$nvmrc_node_version" != (nvm version)
#            echo "Changing node version to $nvmrc_node_version"
#            nvm use
#            set nvm_node_version (nvm version)
#        end
#        echo "$nvm_path/.nvmrc"
#    else if test (nvm version) = "none"
#        nvm use default --silent
#    else if test (nvm version) != (nvm version default)
#        echo "Reverting node version to default"
#        nvm use default
#    end
#end

__check_nvm
