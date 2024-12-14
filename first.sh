#!/usr/bin/bash
x=1
y=2
z=3

if [[ $x -ge $y ]]; then
    echo "x: $x >= y: $y"
elif [[ $y -gt $z ]]; then
    echo "y: $y >= z: $z"
else
    echo "x: $x is the smallest number"
fi