#!/usr/bin/bash

# Rollback and pin Nextcloud flatpak for when they
# decide to break it

ARG="$1"
NEXTCLOUD_FLATPAK_ID=com.nextcloud.desktopclient.nextcloud

if [ "$ARG" == "--unpin" ]; then
    sudo flatpak mask --remove $NEXTCLOUD_FLATPAK_ID
fi

if [ -f /etc/tr-osforge/nextcloud-flatpak-pin ]; then
    . /etc/tr-osforge/nextcloud-flatpak-pin
    sudo flatpak update --commit=$NEXTCLOUD_PINNED_COMMIT $NEXTCLOUD_FLATPAK_ID
    sudo flatpak mask $NEXTCLOUD_FLATPAK_ID
    echo "Nextcloud pinned to commit $NEXTCLOUD_PINNED_COMMIT"
fi
