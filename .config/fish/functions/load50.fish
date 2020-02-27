#
# Expected:	Loads and Unloads libcs50 https://github.com/cs50/libcs50
# Unexpected:	While loaded, Compiling other C programms may not work.
# 		Complete unset of CFLAGS and LDLIBS may aslo break compiling
# 		other C programs.
#
# Alternatives:	cs50/cli @ hub.docker.com <- This is a far more superior tool.
#
# Author: 	Mohamed Omar
# Date Created:	19 Feb 2020
# 
# GitHub: redomar


function _load50on -d "Activate CS50 library"
    export CFLAGS="-fsanitize=signed-integer-overflow -fsanitize=undefined -ggdb3 -O0 -std=c11 -Wall -Werror -Wextra -Wno-sign-compare -Wno-unused-parameter -Wno-unused-variable -Wshadow"
    export LDLIBS="-lcs50 -lm"
    export CSACTIVE="1"
end

# Remove 
function _load50off -d "Deactivate CS50 library"
    if test -z $CSACTIVE=""
	echo -e "CS50 Mode Not active\n"
	_load50_help
	return 1
    end

    set -e CSACTIVE
    set -e CFLAGS
    set -e LDLIBS

    echo "Unset $CFLAGS and $LDLIBS"
end

# Function loader
function load50 -a cmd -d "Load CS50 C Library"
    switch "$cmd"
	case --on
	    _load50on 
	case --off
	    _load50off 
	case {,-}-h{elp,}
	    _load50_help
	case ""
	    echo "load50: no flag or command set" >&2
	    _load50_help >&2
	    return 1
	case \*
	    echo "load50: unknown flag or command \"$cmd\"" >&2
	    _load50_help >&2
	    return 1
    end
end

# Help Menu
function _load50_help
    echo "usage:	load50 --on	Load CS50 C compiler libraries"
    echo "	load50 --off	Unload CS50 C compiler libraries"
    echo "	load50 --help	Show this help"
end

# Autocomplete
complete -f -c load50 -n '__fish_use_subcommand' -a '--on' -d 'Load CS50 C Library'
complete -f -c load50 -n '__fish_use_subcommand' -a '--off' -d 'Unload CS50 C Library'
