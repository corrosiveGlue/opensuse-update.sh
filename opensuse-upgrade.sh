#!/bin/bash

REFRESH() { zypper refresh;}
LIST() { zypper lu;}
PATCH() { zypper patch-check;}
UPGRADE() { zypper ref && sudo zypper dup;}
CLEAN() { zypper clean;}

if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
    exit 1
fi

printf "sudo zypper lu\n"  && LIST

PROMPT() {
    read -p "do you wish to update [Yes/No]" yn
    case $yn in

        [Y/y/]* ) UPGRADE;;
        [N/n]* )  printf "Nothing to do\n" && exit;;

        * ) printf "Nothing to do\n" && exit ;;
    esac
}
REFRESH
PROMPT
PATCH
CLEAN

if [ $? -ne 0 ]
then
    printf "System upgrade failed\n"
else
    printf "System successfully upgraded\n"
fi
