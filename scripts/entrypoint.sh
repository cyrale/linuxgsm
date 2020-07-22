#!/bin/bash

if [ -f /lgsm_bootstrap.sh ]
then
    source /lgsm_bootstrap.sh
fi
source /lgsm_functions.sh

if [ $# = 0 ]
then
    # no command
    fn_check_user

    /lgsm_install.sh
    /lgsm_gameserver.sh
    /lgsm_start.sh
    
    if [ -f /lgsm_console.sh ]
    then
        /lgsm_console.sh
    fi
    
    tail -f /dev/null
else
    # execute the command passed through docker
    "$@"
fi

exit 0