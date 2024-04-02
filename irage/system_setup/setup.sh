#!/bin/bash

function isomount {

 isomnt=$(os=$(cat /etc/os-release | grep -i VERSION_ID | cut -d"=" -f2 | tr -d "\""); \
        locate "rhel-server-$os-x86_64-dvd.iso" | head -n 1)

    if [[ $? -eq 0 ]]; then

        if [[ "$(df -hT /mnt | grep -i iso)" ]]; then
            df -hT /mnt
            return 0
        else
            mount "$isomnt" /mnt
            if [[ "$(df -hT /mnt | grep -i iso)" ]]; then
                df -hT /mnt
                return 0
            else
                return 1
            fi
        fi
    else
        return 1
    fi
}

function repo_creation {
    ./repo.sh
}

function optimize {
    success=()
    unsuccess=()

        for cmd in $(cat optimize.sh); do
            ./cmds_check.sh "$cmd"
            if [[ $? -eq 0 ]]; then
                success+=("$cmd")
            else
                unsuccess+=("$cmd")
            fi
        done
    
    echo "----------optmization commands sucess------------"
    printf '%s\n'  "${success[@]}"
    echo "----------optmization commands sucess------------"
    printf '%s\n'  "${unsuccess[@]}"
    echo "======================="
}

function teng {
    local driver=$1
    local ver=$2
    if [[ "$driver" == "solar" ]]; then
        if [[ "$2" == "7.6" ]]; then
            onload_7.6/build_install_onload_2018.sh
        elif [[ "$ver" == "7.9" ]]; then
            onload_7.9/build_install_openonload_8.sh
        fi
    
    elif [[ "$driver" == "exanic" ]]; then
        if [[ "$ver" == "2.6.1" ]]; then
            ./exanic_2.6.1_install.sh
        elif [[ "$ver" == "2.7.1" ]]; then
            ./exanic_2.7.1_install.sh
        fi
    fi
}

function man {
    echo "setup.sh <input argument>"
    echo "-a     :for complete setup ('optimization' , '10g driver', 'Time sync driver')"
    echo "-o     :for optimization"
    echo "-t     :10g driver and Time_sync"
}

function intruct {
    
}

if [[ $# -eq 0 ]]; then
    man
else
    if isomount; then
        if [[ "$1" == "-a" ]]; then
            if repo_creation; then
                if optimize; then
                    echo "optimization success"
                else
                    echo "\033[1;31m error in optimization commands \033[0m"
                fi
            else
                echo "\033[1;31m error in local repo creation \033[0m"
            fi

        elif [[ "$1" == "-o" ]]; then
            optimize
        elif [[ "$1" == "-t" ]]; then
            teng "$drive" "$version"
        fi
    else
        echo -e "\033[1;31m unable to mount iso \033[0m"
    fi
fi


