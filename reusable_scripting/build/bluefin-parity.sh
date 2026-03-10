#!/usr/bin/bash

set -eou pipefail

###############################################################################
# Main Build Script
###############################################################################
# This script follows the @ublue-os/bluefin pattern for build scripts.
# It uses set -eoux pipefail for strict error handling and debugging.
###############################################################################

# Source helper functions
# shellcheck source=/dev/null
source /ctx/build/copr-helpers.sh


echo "Copying System Files"

mkdir -p /usr/share/ublue-os/just/
shopt -s nullglob
cp -r /ctx/oci/common/bluefin/usr/share/ublue-os/just/* /usr/share/ublue-os/just/
cp -r /ctx/oci/common/bluefin/usr/share/backgrounds/* /usr/share/backgrounds
rsync -av \
	--exclude=etc/profile.d/ublue-fastfetch.sh \
 /ctx/oci/common/shared/ /
cp -r /ctx/oci/tr-osforge/system_files/bluefin-parity/* / 
shopt -u nullglob


echo "Installing Gnome Extensions"

/tmp/scripts/run_module.sh 'gnome-extensions' \
    '{"type":"gnome-extensions","install":["AppIndicator and KStatusNotifierItem Support","Blur my Shell","Logo Menu"]}'
# Temporary workaround for https://github.com/micheleg/dash-to-dock/issues/2413
# Remove when v104 of the extension is relased
dnf5 -y --setopt=install_weak_deps=False install \
	gnome-shell-extension-dash-to-dock
	
echo "Installing packages"

# Note pcsc-lite will be needed for Alma
dnf5 -y --setopt=install_weak_deps=False install \
	clinfo \
	fastfetch \
	ffmpegthumbnailer \
	firewall-config \
	fzf \
	glow \
	gnome-disk-utility \
	gnome-tweaks \
	gum \
	lm_sensors \
	nss-mdns \
	openssh-askpass \
	papers-thumbnailer  \
	powertop \
	rclone \
	restic \
	setools-console \
	waypipe \
	wl-clipboard \
    desktop-backgrounds-waves \
    socat \
    xdg-terminal-exec \
	yq

copr_install_isolated ublue-os/packages uupd


echo "Disabling non-ublue update mechanisms" 

systemctl disable rpm-ostreed-automatic.timer
systemctl disable flatpak-system-update.timer
systemctl disable bootc-fetch-apply-updates.timer


echo "Setting up non-Bluefin ublue-motd"

cat > /usr/share/ublue-os/motd/env.sh << ENV.SH
#!/usr/bin/env sh
# KEEP THIS SMALL
# This will run on every shell that a user starts up.
export MOTD_IMAGE_NAME=$IMAGE_NAME
export MOTD_IMAGE_TAG=$TAG
ENV.SH

cat > /usr/share/ublue-os/motd/template.md << "TEMPLATE.MD"
This bootc based system is running
ghcr.io/rrenomeron/${MOTD_IMAGE_NAME}:${MOTD_IMAGE_TAG}

TEMPLATE.MD


echo "Adding Cascadia Code"
/tmp/scripts/run_module.sh 'fonts' \
  '{ "type": "fonts", "fonts" : {"url-fonts": [ { "name": "cascadia-code", "url": "https://github.com/microsoft/cascadia-code/releases/download/v2407.24/CascadiaCode-2407.24.zip" } ] }}'


echo "Adding Ptyxis Configuration"

glib-compile-schemas /usr/share/glib-2.0/schemas

