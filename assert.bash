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
# $ assert "str_val" "str_val"     # string comparison
# OK
# $ assert "str_val" "str_val2"    # if assertion failure, show arguments.
# ERR str_val str_val2
# $ assert 2 -gt 1                 # numeric comparison
# OK
# $ assert 2 -lt 1
# ERR 2 -lt 1
# $ assert "str_val" match val$    # regexp
# OK
# $ assert "str_val" match ^val
# ERR str_val match ^val
# $ assert -f exists.txt           # file exists
# OK
# $ assert -d nothing/dir          # directory exists
# ERR -d nothing/dir
# $ assert same.txt cmp same.txt   # file contents equal
# OK
# $ assert same.txt cmp diff.txt
# ERR same.txt cmp diff.txt
# $ assert same.txt !cmp diff.txt  # file contents not equal
# OK
# $ assert same.txt !cmp same.txt
# ERR same.txt cmp same.txt
#
# Author : yosugi
# License: MIT

function assert() {
    # 2 arguments test
    if [ $# -eq 2 ]; then
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
    fi

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

    # file contents equal test
    if [ $2 = 'cmp' ]; then
        eval cmp -s "$1" "$3"
        if [[ $? -eq 0 ]]; then
            echo "OK"
            return 0
        fi
        echo "ERR $@"
        return 1
    fi

    # file contents not equal test
    if [ $2 = '!cmp' ]; then
        eval cmp -s "$1" "$3"
        if [[ $? -eq 1 ]]; then
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
}
