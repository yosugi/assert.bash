#!/bin/bash
#
# run command
#
#   bash test.bash

source assert.bash

function main() {
    local actual

    # string OK
    actual=$(assert "ls -al" "ls -al")
    [ $? = 0 ] && echo "OK" || echo "NG"
    [ "$actual" = "OK" ] && echo "OK" || echo "NG"

    actual=$(assert "-f" = "-f")
    [ $? = 0 ] && echo "OK" || echo "NG"
    [ "$actual" = "OK" ] && echo "OK" || echo "NG"

    # string ERR
    actual=$(assert "ls -al" = "ls -ltr")
    [ $? = 1 ] && echo "OK" || echo "NG"
    [ "$actual" = "ERR ls -al = ls -ltr" ] && echo "OK" || echo "NG"

    actual=$(assert "-d" = "-f")
    [ $? = 1 ] && echo "OK" || echo "NG"
    [ "$actual" = "ERR -d = -f" ] && echo "OK" || echo "NG"

    # numeric
    actual=$(assert 2 -gt 1)
    [ $? = 0 ] && echo "OK" || echo "NG"
    [ "$actual" = "OK" ] && echo "OK" || echo "NG"

    actual=$(assert 2 -lt 1)
    [ $? = 1 ] && echo "OK" || echo "NG"
    [ "$actual" = "ERR 2 -lt 1" ] && echo "OK" || echo "NG"

    # regexp
    actual=$(assert "str_val" match val$)
    [ $? = 0 ] && echo "OK" || echo "NG"
    [ "$actual" = "OK" ] && echo "OK" || echo "NG"

    actual=$(assert "str_val" match ^val)
    [ $? = 1 ] && echo "OK" || echo "NG"
    [ "$actual" = "ERR str_val match ^val" ] && echo "OK" || echo "NG"

    local test_file="$test_dir/test_file.txt"
    echo "test" > $test_file

    # directory exists
    actual=$(assert -d "$test_dir")
    [ $? = 0 ] && echo "OK" || echo "NG"
    [ "$actual" = "OK" ] && echo "OK" || echo "NG"

    actual=$(assert -d "$test_dir/nothing")
    [ $? = 1 ] && echo "OK" || echo "NG"
    [ "$actual" = "ERR -d $test_dir/nothing" ] && echo "OK" || echo "NG"

    # file exists
    actual=$(assert -f "$test_file")
    [ $? = 0 ] && echo "OK" || echo "NG"
    [ "$actual" = "OK" ] && echo "OK" || echo "NG"

    actual=$(assert -f "$test_dir/nothing_file")
    [ $? = 1 ] && echo "OK" || echo "NG"
    [ "$actual" = "ERR -f $test_dir/nothing_file" ] && echo "OK" || echo "NG"

    # file contents equal
    local same_file="$test_dir/same_file.txt"
    local diff_file="$test_dir/diff_file.txt"
    echo "same" > $same_file
    echo "diff" > $diff_file

    actual=$(assert $same_file cmp $same_file)
    [ $? = 0 ] && echo "OK" || echo "NG"
    [ "$actual" = "OK" ] && echo "OK" || echo "NG"

    actual=$(assert $same_file cmp $diff_file)
    [ $? = 1 ] && echo "OK" || echo "NG"
    [ "$actual" = "ERR $same_file cmp $diff_file" ] && echo "OK" || echo "NG"

    # file contents not equal
    actual=$(assert $same_file !cmp $diff_file)
    [ $? = 0 ] && echo "OK" || echo "NG"
    [ "$actual" = "OK" ] && echo "OK" || echo "NG"

    actual=$(assert $same_file !cmp $same_file)
    [ $? = 1 ] && echo "OK" || echo "NG"
    [ "$actual" = "ERR $same_file !cmp $same_file" ] && echo "OK" || echo "NG"
}

test_dir="./test_dir"
mkdir -p $test_dir

main

rm -rf $test_dir
