#!/bin/bash

if [ -f /lgsm_bootstrap.sh ]
then
    source /lgsm_bootstrap.sh
fi

source /lgsm_functions.sh
source /lgsm_variables.sh

if [ $# = 0 ]
then
    # no command
    fn_check_user

    source /lgsm_install.sh
    source /lgsm_gameserver.sh
    source /lgsm_start.sh

    if [ -f /lgsm_console.sh ]
    then
        source /lgsm_console.sh
    fi

    tail -f /dev/null
else
    # execute the command passed through docker
    "$@"
fi

exit 0
