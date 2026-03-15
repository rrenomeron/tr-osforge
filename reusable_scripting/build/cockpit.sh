#!/usr/bin/bash

set -eoux pipefail

echo "Installing Cockpit packages"

$DNF_CMD -y --setopt=install_weak_deps=False install \
    cockpit-networkmanager \
    cockpit-ostree \
    cockpit-bridge \
    cockpit-podman \
    cockpit-selinux \
    cockpit-storaged \
    cockpit-system \
    cockpit-files

echo "done"