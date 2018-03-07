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
# $ assert "str_val" "str_val"  # string comparison
# OK
# $ assert "str_val" "str_val2" # if assertion failure, show arguments.
# ERR str_val str_val2
# $ assert 2 -gt 1              # numeric comparison
# OK
# $ assert 2 -lt 1
# ERR 2 -lt 1
# $ assert "str_val" /val$/     # regexp
# OK
# $ assert "str_val" /^val/
# ERR str_val /^val/
#
# Author : yosugi
# License: MIT

function assert() {
    # numeric test
    if [ $# -eq 3 ]; then
        if [ $1 $2 $3 ]; then
            echo "OK"
            return 0
        fi
        echo "ERR $1 $2 $3"
        return 1
    fi

    local regexp
    regexp=`expr $2 : '^/\(.*\)/$'`

    # regexp test
    if [ $? = 0 ]; then
        if [[ $1 =~ $regexp ]]; then
            echo "OK"
            return 0
        fi
        echo "ERR $1 $2"
        return 1
    fi

    # string test
    if [ $1 = $2 ]; then
        echo "OK"
        return 0
    else
        echo "ERR $1 $2"
        return 1
    fi
}
