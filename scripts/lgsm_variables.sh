#!/bin/bash

source /lgsm_functions.sh

fn_check_user

lgsm_script="${HOME}/linuxgsm.sh"
lgsm_dir="${HOME}/lgsm"
config_dir="${lgsm_dir}/config-lgsm"
server_config_dir="${config_dir}/${LGSM_GAMESERVER}"
server_config_file="${server_config_dir}/${LGSM_GAMESERVER}.cfg"
common_config_file="${server_config_dir}/common.cfg"

gameserver_original_script="${HOME}/${LGSM_GAMESERVER}"
gameserver_renamed_script="${HOME}/$(fn_sanitize_string ${LGSM_GAMESERVER_RENAME})"
