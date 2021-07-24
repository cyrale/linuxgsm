:warning:

Sorry, I have no more time to maintain this project and I no longer play ProjectZomboid to properly follow its progress. Feel free to fork this project and continue this work on your side.

# Linux Game Server Managers\_ - Docker image

Docker version of [LinuxGSM\_](https://github.com/GameServerManagers/LinuxGSM).

## How to use this image

This image must not be run directly.

It's a partial image and must be used by a Dockerfile `FROM ghcr.io/cyrale/linuxgsm`. See [cyrale/project-zomboid](https://github.com/cyrale/project-zomboid) for example.

## Variables

- **LGSM_VERSION** Set the version of LinuxGSM\_ to use (ex.: `v20.4.0`). To update to the latest version after each restart, set it to `latest` (default: latest)
- **LGSM_GAMESERVER** Name of the game server. Supported [game server list](https://linuxgsm.com/servers/).
- **LGSM_GAMESERVER_UPDATE** Enable automatic update of the game server at restart (default: true)
- **LGSM_GAMESERVER_START** Enable automatic start of the game server at restart (default: false)
- **LGSM_GAMESERVER_RENAME** Rename the game server
- **LGSM_COMMON_CONFIG** This variable set the content of the common settings file
- **LGSM_COMMON_CONFIG_FILE** Load the content of the file to set the content of the common settings file
- **LGSM_SERVER_CONFIG** This variable set the content of the instance settings file
- **LGSM_SERVER_CONFIG_FILE** Load the content of the file to set the content of the instance settings file

For configuration options, you can see all default settings on [GitHub](https://github.com/GameServerManagers/LinuxGSM/tree/master/lgsm/config-default/config-lgsm)

## Volumes

No volumes mounted.

## Expose

No ports exposed.
