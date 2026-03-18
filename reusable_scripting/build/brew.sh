#!/usr/bin/bash

set -eoux pipefail

echo "Copying brew installation"

cp -r /ctx/oci/brew/system_files/* /

echo "Enabling brew update systemd unit"
systemctl enable brew-setup