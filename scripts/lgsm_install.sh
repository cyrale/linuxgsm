#!/bin/bash

source /lgsm_functions.sh
source /lgsm_variables.sh

fn_check_user

lgsm_install_latest="https://linuxgsm.sh"
lgsm_install="${lgsm_install_latest}"

cd "${HOME}"

if [ $(fn_is_lgsm_installed) == "OK" ] && [ "$(fn_lgsm_file_version ${lgms_script})" == "$(fn_lgsm_version)" ]
then
    exit 0
fi

# Set specific version of LinuxGSM_
if [ "$(fn_lgsm_version)" != "latest" ]
then
    lgsm_install="https://raw.githubusercontent.com/GameServerManagers/LinuxGSM/$(fn_lgsm_version)/linuxgsm.sh"

    # Check if specific version exists
    if [ "$(fn_validate_url ${lgsm_install})" != "OK" ]
    then
        lgsm_install="${lgms_script_latest}"
    fi
fi

# Download install script
echo -e "Download LinuxGSM_ script from ${lgsm_install}"
wget -q -O "${lgsm_script}" $lgsm_install
chmod +x "${lgsm_script}"
