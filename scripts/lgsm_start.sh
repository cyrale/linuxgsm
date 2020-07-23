#!/bin/bash

source /lgsm_functions.sh
source /lgsm_variables.sh

fn_check_user
fn_check_lgsm_installed

if [ "${LGSM_GAMESERVER_START}" != "true" ]
then
    exit 0
fi

cd "${HOME}"

lgsm_gameserver_script="${gameserver_original_script}"

if [ ! -z "${LGSM_GAMESERVER_RENAME}" ]
then
    lgsm_gameserver_script="${gameserver_renamed_script}"
fi

$lgsm_gameserver_script start
