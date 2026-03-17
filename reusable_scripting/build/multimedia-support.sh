#!/usr/bin/bash

set -eoux pipefail
source /ctx/oci/tr-osforge/build/helpers/utils.sh
# Multimedia Support from Negativo

$DNF_CMD config-manager --add-repo https://negativo17.org/repos/epel-multimedia.repo

$DNF_CMD install -y \
    @Multimedia \
    ffmpeg \
    libavcodec \
    lame \
    lame-libs \
    libjxl \
    jxl-pixbuf-loader