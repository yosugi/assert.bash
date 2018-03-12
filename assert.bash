#!/bin/bash
# 
# assert.bash
#
# Description:
#
# Simple assert function for bash.
#
# Usage:
#
# $ source assert.bash
# $ assert "str_val" "str_val"   # string comparison
# OK
# $ assert "str_val" "str_val2"  # if assertion failure, show arguments.
# ERR str_val str_val2
# $ assert 2 -gt 1               # numeric comparison
# OK
# $ assert 2 -lt 1
# ERR 2 -lt 1
# $ assert "str_val" match val$  # regexp
# OK
# $ assert "str_val" match ^val
# ERR str_val match ^val
# $ asseret -f exits.txt         # file exists
# OK
# $ asseret -d nothing/dir       # directory exists
# ERR -d nothing/dir
#
# Author : yosugi
# License: MIT

function assert() {
    # regexp test 
    if [ $# -eq 3 ]; then
        # regexp test
        if [ $2 = 'match' ]; then
            local regexp
            regexp=$3
            if [[ $1 =~ $regexp ]]; then
                echo "OK"
                return 0
            fi
            echo "ERR $@"
            return 1
        fi
    
        # other test
        if [ "$1" "$2" "$3" ]; then
            echo "OK"
            return 0
        fi
        echo "ERR $@"
        return 1
    fi
    
    # other test
    expr "$1" : "^-[zndfserwx]$" > /dev/null
    if [ $? = 0 ]; then
        if [ "$1" "$2" ]; then
            echo "OK"
            return 0
        fi
        echo "ERR $@"
        return 1
    fi
   
    # string test
    if [ "$1" = "$2" ]; then
        echo "OK"
        return 0
    else
        echo "ERR $1 $2"
        return 1
    fi
}
