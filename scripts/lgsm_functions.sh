#!/bin/bash

fn_apply_configuration() {
    local config_file="${1}"
    local lgsm_config="${2}"
    local lgsm_config_file="${3}"

    if [ ! -z "${lgsm_config_file}" ] && [ -f "${lgsm_config_file}" ]
    then
        cat "${lgsm_config_file}" > "${config_file}"
    elif [ ! -z "${lgsm_config}" ]
    then
        echo "${lgsm_config}" > "${config_file}"
    fi
}

# Prevent LinuxGSM_ from running as another user than linuxgsm.
fn_check_user() {
    if [ "$(whoami)" != "linuxgsm" ]
    then
        echo -e "Do NOT run this script as another user than linuxgsm!"
        exit 1
    fi
}

fn_check_lgsm_installed() {
    if [ "$(fn_is_lgsm_installed)" != "OK" ]
    then
        echo -e "LinuxGSM_ is not installed!"
        exit 1
    fi
}

fn_is_lgsm_installed() {
    [ -f "${HOME}/linuxgsm.sh" ] && echo "OK" || echo "KO"
}

fn_lgsm_file_version() {
    if [ -f "${1}" ]
    then
        echo $(cat "${1}" | grep "version=" -m1 | sed -r "s/version=\"([^\"]+)\"/\1/")
    fi
}

fn_lgsm_version() {
    if [[ "${LGSM_VERSION}" =~ ^v[0-9]{2}\.[0-9]{1,2}\.[0-9]{1,2}$ ]]
    then
        echo "${LGSM_VERSION}"
    else
        echo "latest"
    fi
}

fn_sanitize_string() {
    local sanitized="${1}"

    # First, replace spaces with dashes
    sanitized=${sanitized// /-/}
    # Now, replace anything that's not alphanumeric, an underscore or a dash
    sanitized=${sanitized//[^a-zA-Z0-9_-]/-/}
    # Finally, lowercase with TR
    sanitized=`echo -n $sanitized | tr A-Z a-z`

    echo "${sanitized}"
}

fn_validate_url() {
    $(wget -O /dev/null -q "${1}") && echo "OK" || echo "KO"
}