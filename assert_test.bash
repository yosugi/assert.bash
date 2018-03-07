#!/bin/bash
#
# bash assert_test.bash

source assert.bash

function main() {
    local actual

    # string OK
    actual=`assert "str_val" "str_val"`
    [ $? = 0 ] && echo "OK" || echo "NG"
    [ "$actual" = "OK" ] && echo "OK" || echo "NG"

    # string ERR
    actual=`assert "str_val" "str_val2"`
    [ $? = 1 ] && echo "OK" || echo "NG"
    [ "$actual" = "ERR str_val str_val2" ] && echo "OK" || echo "NG"

    # numeric OK
    actual=`assert 2 -gt 1`
    [ $? = 0 ] && echo "OK" || echo "NG"
    [ "$actual" = "OK" ] && echo "OK" || echo "NG"

    # numeric ERR
    actual=`assert 2 -lt 1`
    [ $? = 1 ] && echo "OK" || echo "NG"
    [ "$actual" = "ERR 2 -lt 1" ] && echo "OK" || echo "NG"

    # regexp OK
    actual=`assert "str_val" /val$/`
    [ $? = 0 ] && echo "OK" || echo "NG"
    [ "$actual" = "OK" ] && echo "OK" || echo "NG"

    # regexp ERR
    actual=`assert "str_val" /^val/`
    [ $? = 1 ] && echo "OK" || echo "NG"
    [ "$actual" = "ERR str_val /^val/" ] && echo "OK" || echo "NG"
}

main
