FROM archlinux:latest

ENV GOSU_VERSION=1.14

RUN sed -i '/^NoExtract/d' /etc/pacman.conf && \
    pacman-key --init && pacman -Sy --noconfirm && \
    pacman -Qqn --noconfirm | pacman -S --noconfirm - && \
    sed -i '$ a\[multilib]\nInclude = \/etc\/pacman.d\/mirrorlist' /etc/pacman.conf && \
    pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
    jq \
    vim \
    # OPTIONAL DRIVERS \
    # mesa \
    # lib32-mesa \
    # libva-mesa-driver \
    # lib32-libva-mesa-driver \
    # mesa-vdpau \
    # lib32-mesa-vdpau \
    # install vulkan-radeon for DirectX12 \
    # vulkan-radeon \
    # lib32-vulkan-radeon \
    wine \
    wine-mono \
    # for TSL support to autoupdate PoB \
    samba lib32-gnutls gnutls && \
    # Install gosu https://github.com/tianon/gosu
    curl -o /usr/bin/gosu -L "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64" && \
    chmod +x /usr/bin/gosu

ENV USER_UID=1000
ENV USER_GID=${USER_UID}
ENV USER_NAME="pobuser"
ENV USER_HOME="/home/${USER_NAME}"

# User needs audio group for raw ALSA to work
RUN groupadd --gid "${USER_GID}" "${USER_NAME}" && \
    useradd --shell /bin/bash --uid "${USER_UID}" --gid "${USER_GID}" \
      --no-create-home --home-dir "${USER_HOME}" "${USER_NAME}" && \
    mkdir -p /var/lib/dbus && \
    dbus-uuidgen > /var/lib/dbus/machine-id 

# DOWNLOAD POB
WORKDIR /opt/
RUN curl -s https://api.github.com/repos/PathOfBuildingCommunity/PathOfBuilding/releases/latest > latest.json && \
    curl -OL $(jq -r  '.assets[1].browser_download_url' latest.json)

WORKDIR $USER_HOME

COPY entrypoint.sh /usr/bin/entrypoint
ENTRYPOINT ["/usr/bin/entrypoint"]
