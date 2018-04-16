#!/bin/bash
# Author : AMIR MOHAMMADI
# A simple shell script for personal usage :)))
# Under GPL v.3 License

# Eg1: crun source.cpp
# Eg2: crun /the/place/of/source.cpp
# Eg3: crun -m file1.cpp -m file2.cpp -m file3.cpp

FILES=()

function ifExist {
    if [[ ! -f "$1" ]]; then
        result=0
    else
        result=1
    fi
}

function remove {
    ifExist $1
    if [[ "$result" -eq "1" ]]; then
        $(rm $1)
    fi
}

function compile {
    $(g++ $1 -o $2)
    # This file will run after compiling
    runFile=$(echo $1 | cut -d "." -f 1)
    # If couldn't compile the file then exit
    ifExist $2
    if [[ "$result" -eq "0" ]]; then
        echo -e "\033[0;31m" "Ohhh! I couldn't compile your file :/" "\033[0m"
        exit
    else
        clear
    fi
}

function run {
    # Checks if project is here or you compile it from another directory
    if [[ $runFile = *"/"* ]]; then
        # In this case the project is in another directory
        $runFile
    else
        # In this case the project is in this directory
        runFile="./"$runFile
        $runFile
    fi
}

# main -------------------------------
while test $# -gt 0; do
    case $1 in
    -m|--multiple)
        shift
        FILES+=("$1")
        shift
        ;;
    *)
        FILES=$1
        break
        ;;
    esac
done

outPut=$(echo ${FILES[0]} | cut -d "." -f1)  
# First check if there's an old compiled file remove that and then continue
remove $outPut
compile ${FILES[@]} $outPut
run
exit
