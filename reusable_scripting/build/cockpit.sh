#!/usr/bin/bash

set -eoux pipefail
source /ctx/oci/tr-osforge/build/helpers/utils.sh

echo "Installing Cockpit packages"

$DNF_CMD -y --setopt=install_weak_deps=False install \
    cockpit-networkmanager \
    cockpit-ostree \
    cockpit-bridge \
    cockpit-podman \
    cockpit-selinux \
    cockpit-storaged \
    cockpit-system \
    cockpit-files \
    pcp

echo "done"