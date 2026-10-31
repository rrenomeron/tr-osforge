#!/usr/bin/bash

set -eoux pipefail
source /ctx/oci/tr-osforge/build/helpers/utils.sh
# Multimedia Support from Negativo
if [ "$BASE_OS_TYPE" == "fedora" ]; then
    dnf5 config-manager setopt fedora-multimedia.enabled=1 ||
    dnf5 config-manager addrepo --from-repofile="https://negativo17.org/repos/fedora-multimedia.repo"
    dnf5 install -y \
        alsa-ucm \
        alsa-utils \
        gstreamer1-plugins-bad-free \
        gstreamer1-plugins-good \
        gstreamer1-plugins-ugly-free \
        pipewire \
        pipewire-alsa \
        pipewire-gstreamer \
        pipewire-jack-audio-connection-kit \
        pipewire-pulseaudio \
        pipewire-utils
else
    $DNF_CMD config-manager --add-repo https://negativo17.org/repos/epel-multimedia.repo
    $DNF_CMD install -y \
        @Multimedia
fi
    $DNF_CMD install -y \
        ffmpeg \
        libavcodec \
        lame \
        lame-libs \
        libjxl \
        jxl-pixbuf-loader
