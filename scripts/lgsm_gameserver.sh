#!/bin/bash

source /lgsm_functions.sh
source /lgsm_variables.sh

fn_check_user
fn_check_lgsm_installed

if [ -z "${LGSM_GAMESERVER}" ]
then
    exit 0
fi

cd "${HOME}"

lgsm_gameserver_script="${gameserver_original_script}"

if [ ! -f "${gameserver_original_script}" ] && [ ! -f "${gameserver_original_script}" ]
then
    # First installation

    # Install server script
    echo -e "Install LinuxGSM_ game server"
    $lgsm_script "${LGSM_GAMESERVER}"

    # Rename server script
    if [ ! -z "${LGSM_GAMESERVER_RENAME}" ]
    then
        echo -e "Rename LinuxGSM_ game server"
        mv "${gameserver_original_script}" "${gameserver_renamed_script}"

        lgsm_gameserver_script="${gameserver_renamed_script}"
        server_config_file="${server_config_dir}/$(fn_sanitize_string ${LGSM_GAMESERVER_RENAME}).cfg"
    fi

    # Install game server
    echo -e "Install game server"
    $lgsm_gameserver_script auto-install
else
    # Already installed

    # Search renamed script
    if [ ! -z "${LGSM_GAMESERVER_RENAME}" ]
    then
        lgsm_gameserver_script="${gameserver_renamed_script}"
        server_config_file="${server_config_dir}/$(fn_sanitize_string ${LGSM_GAMESERVER_RENAME}).cfg"
    fi

    # Update script
    if [ "$(fn_lgsm_version)" == "latest" ]
    then
        echo -e "Update LinuxGSM_ game server to the latest version"
        $lgsm_gameserver_script update-lgsm
    elif [ "$(fn_lgsm_file_version ${lgsm_script})" != "$(fn_lgsm_file_version ${lgsm_gameserver_script})" ]
    then
        # Remove older version
        echo -e "Remove older version of LinuxGSM_ game server"
        rm -rf "${lgsm_gameserver_script}" "${lgsm_dir}/functions"

        # Install new version
        echo -e "Update LinuxGSM_ game server"
        $lgsm_script "${LGSM_GAMESERVER}"

        # Rename new version of server script
        if [ ! -z "${LGSM_GAMESERVER_RENAME}" ]
        then
            echo -e "Rename new version of LinuxGSM_ game server"
            mv "${gameserver_original_script}" "${gameserver_renamed_script}"
        fi
    fi
fi

echo -e "Apply common configuration"
fn_apply_configuration "${common_config_file}" "${LGSM_COMMON_CONFIG}" "${LGSM_COMMON_CONFIG_FILE}"

echo -e "Apply game server configuration"
fn_apply_configuration "${server_config_file}" "${LGSM_SERVER_CONFIG}" "${LGSM_SERVER_CONFIG_FILE}"

if [ -f /lgsm_configuration.sh ]
then
    /lgsm_configuration.sh
fi

# Update game server
if [ "${LGSM_GAMESERVER_UPDATE}" == "true" ]
then
    echo -e "Update game server"
    $lgsm_gameserver_script update
fi

echo -e "Game server installed and updated!"
