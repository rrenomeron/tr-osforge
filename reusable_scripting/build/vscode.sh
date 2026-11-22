#!/usr/bin/bash

set -eou pipefail
source /ctx/oci/tr-osforge/build/helpers/utils.sh

# On Fedora 45, add OpenSSL 3 so that extension install will work
# See https://computingforgeeks.com/install-visual-studio-code-on-fedora/

if [ "$BASE_OS_TYPE" == "fedora" ] && [ "$FEDORA_VERSION" == "45" ]; then
    PKGS_TO_INSTALL="code openssl3-libs"
else
    PKGS_TO_INSTALL=code
fi

echo "Installing Visual Studio Code"
cat > /etc/yum.repos.d/vscode.repo << EOF
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

$DNF_CMD -y install $PKGS_TO_INSTALL

rm -rf /etc/yum.repos.d/vscode.repo

echo "Visual Studio Code installed successfully"