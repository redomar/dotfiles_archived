#
# Abbreviations
#
abbr -a a "xdcc-dl"
abbr -a ari "aria2c"
abbr -a c "code ."
abbr -a cl "clear"
abbr -a e "ssh eagle"
abbr -a lll "tree -L 1 -d"
abbr -a nodem "./node_modules/.bin/nodemon"
abbr -a o "open ."
abbr -a p "python"
abbr -a py "pyenv activate"
abbr -U v "vim"
abbr -a vif "vim ~/.config/fish/config.fish"

#
# Aliases
#
alias config="/usr/local/bin/git --git-dir=$HOME/gitBareDotFiles --work-tree=$HOME"
alias m="~/Documents/mpv.app/Contents/MacOS/mpv"
alias vimoder="fish_vi_key_bindings"
alias vinorm="fish_default_key_bindings"

#
# Custom Variables
#
function servos -d "Connect to servos server via ssh"
  # Connect as default user
  if test -z $argv[1]
    ssh redomar
    return
  end
  # connect a specific user@
  if echo $argv[1] | grep -Eq "\w+\@"
    ssh {$argv[1]}redomar
    return
  end
  # chech prefix modifier
  echo $argv | read -l prefix user
  # append modifier and prefix user
  for option in $argv[1]
    ssh {$prefix} {$user}redomar
  end
end

function sgit -d "Use ssh to git clone"
  echo $argv | sed "s/https:\/\//git@/" | sed "s/\$/\.git/" | sed "s/com\//com:/" | read -l link
  git clone $link
end
#
# Environmental Variables
#

# c-lang
export CC="clang" # More C lib functions folder ./functions/cs.fish
# rust-lang cargo
source $HOME/.cargo/env

# GNU Varient unix utils
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"

# pkgconfig ncurses
export PKG_CONFIG_PATH="/usr/local/Cellar/ncurses/6.1_1/lib/pkgconfig"
# pkgconfig sqlite
set -gx PKG_CONFIG_PATH "/usr/local/opt/sqlite/lib/pkgconfig" $PKG_CONFIG_PATH 
# pkgconfig gstreamer1.0
set -gx PKG_CONFIG_PATH "/usr/local/Cellar/gstreamer/1.16.2/lib/pkgconfig" $PKG_CONFIG_PATH
set -g fish_user_paths "/usr/local/opt/sqlite/bin" $fish_user_paths
set -gx LDFLAGS "-L/usr/local/opt/sqlite/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/sqlite/include"

# python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
# pyenv
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
status --is-interactive; and pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source

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
  if test -z "$NVM_BIN"
    return
  end

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

__check_nvm
