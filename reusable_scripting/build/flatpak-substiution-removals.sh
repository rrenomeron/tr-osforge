#!/usr/bin/bash

set -oeu pipefail
source /ctx/oci/tr-osforge/build/helpers/utils.sh

if [ "$BASE_OS_TYPE" == "almalinux" ]; then
	$DNF_CMD -y remove \
		baobab \
		gnome-calculator \
		gnome-characters \
		gnome-clocks \
		gnome-font-viewer \
		gnome-text-editor \
		papers \
		snapshot \
		loupe \
		PackageKit  \
		PackageKit-command-not-found 
	# 	gnome-extensions-app
fi

dnf -y remove \
	gnome-disk-utility \
	gnome-software