#!/bin/sh
TZ=${TZ:-UTC}
ln -snf "/usr/share/zoneinfo/${TZ}" /etc/localtime && echo "${TZ}" > /etc/timezone

# Create home if it doesn't exist
# We have mounted this directory at this point
[ ! -d "${USER_HOME}" ] && mkdir -p "${USER_HOME}"
# Take ownership of user's home directory if owned by root
OWNER_IDS="$(stat -c "%u:%g" "${USER_HOME}")"
if [ "${OWNER_IDS}" != "${USER_UID}:${USER_GID}" ]; then
    if [ "${OWNER_IDS}" == "0:0" ]; then
        echo "Changing home ownership for user $USER_UID"
        chown -R "${USER_UID}":"${USER_GID}" "${USER_HOME}"
    else
        echo "ERROR: User's home '${USER_HOME}' is currently owned by $(stat -c "%U:%G" "${USER_HOME}")"
        exit 1
    fi
fi

# C:\users\pobuser\AppData\Roaming\Path of Building Community
POB_DEFAULT_EXE="$USER_HOME/.wine/drive_c/users/pobuser/AppData/Roaming/Path of Building Community/Path of Building.exe"
export GDK_SCALE=2

if [ -f "$POB_DEFAULT_EXE" ]
then
    gosu "${USER_NAME}" wine "$POB_DEFAULT_EXE"
else
    # echo "Running PoB first time. Installing into the default volume. Follow the prompts and finally run the pob script again." &&
    # exec gosu "${USER_NAME}" /bin/bash "$@"
    exec gosu "${USER_NAME}" wine /opt/PathOfBuildingCommunity-Setup-*.exe

fi
