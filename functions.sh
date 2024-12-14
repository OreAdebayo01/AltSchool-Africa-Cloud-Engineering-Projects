#!/usr/bin/bash

: << 'END_COMMENT'
Syntax  of functions in Bash scripting
function_name() {
    <commands>
}
OR
function function_name {
    <commands>
}
END_COMMENT

number_doubler() {
    local result=$(($1 * 2))
    return $result
}

number_doubler 4
# 4 is passed as an arguement to the function

echo "$?" 
# ? retrieves the return value of the last command, i.e. number_doubler 4
