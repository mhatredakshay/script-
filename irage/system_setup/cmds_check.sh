#!/bin/bash

function cmds {

    local cmd=$1
    if [[ -n "$cmd" && "$cmd" != "#"* ]]; then
        echo -e "\033[0;32m Executing: $cmd \033[0m"
        $cmd
        result=$?
        if [[ $result -eq 0 ]]; then
            echo -e "\033[01;32m $cmd executed succesfully \033[0m"
            return 0
        else
            echo -e "\033[1;31m unable execute $cmd \033[0m"
            return 1
        fi
        echo "-----------------------------------"
    fi
}

cmds "$1"