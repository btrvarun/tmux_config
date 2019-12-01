#!/bin/bash

export rand_number=$(expr $RANDOM % 10)

if [ $rand_number -eq 0 ]; then
    echo "It's okay. We got this"
fi
if [ $rand_number -eq 1 ]; then
    echo "I know it's hard but we'll be okay"
fi
if [ $rand_number -eq 2 ]; then
    echo "Let's get some music going here!"
fi
if [ $rand_number -eq 3 ]; then
    echo "Calm down, take a breather"
fi
if [ $rand_number -eq 4 ]; then
    echo "Coffee, dear boy?"
fi
if [ $rand_number -eq 5 ]; then
    echo "It's alright, you did good today"
fi
if [ $rand_number -eq 6 ]; then
    echo "Stunning beard, by the way"
fi
if [ $rand_number -eq 7 ]; then
    echo "Chocolate time? We deserve it"
fi
if [ $rand_number -eq 8 ]; then
    echo "Perfection is the key, and what are we if not perfect?"
fi
if [ $rand_number -eq 9 ]; then
    echo "Have some water, get some food, We good now"
fi
if [ $rand_number -eq 10]; then
    echo "Darkness shall never tame us"
fi
