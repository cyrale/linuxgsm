#!/bin/bash

source /lgsm_functions.sh

fn_check_user

lgsm_installation_file="${HOME}/.lgsm_installed"
lgsm_script_latest="https://linuxgsm.sh"
lgsm_script="${lgsm_script_latest}"
lgsm_filename="${HOME}/linuxgsm.sh"

cd $HOME

if [ $(fn_is_lgsm_installed) == "OK" ] && [ "$(fn_lgsm_file_version ${lgsm_filename})" == "$(fn_lgsm_version)" ]
then
    exit 0
fi

# Set specific version of LinuxGSM_
if [ "$(fn_lgsm_version)" != "latest" ]
then
    lgsm_script="https://raw.githubusercontent.com/GameServerManagers/LinuxGSM/$(fn_lgsm_version)/linuxgsm.sh"

    # Check if specific version exists
    if [ "$(fn_validate_url ${lgsm_script})" != "OK" ]
    then
        lgsm_script="${lgms_script_latest}"
    fi
fi

# Download install script
echo -e "Download LinuxGSM_ script from ${lgsm_script}"
wget -q -O "${lgsm_filename}" $lgsm_script
chmod +x "${lgsm_filename}"
