#!/usr/bin/bash
set -eoux pipefail
source /ctx/oci/tr-osforge/build/helpers/utils.sh

MSEDIT_VERSION=2.0.0
curl -sfL https://github.com/microsoft/edit/releases/download/v$MSEDIT_VERSION/edit-$MSEDIT_VERSION-x86_64-linux-gnu.tar.gz \
    > /tmp/msedit.tar.gz

tar -C /tmp -xvzf /tmp/msedit.tar.gz
cp /tmp/edit /usr/bin

# Needed for "find" command to work.  See https://github.com/microsoft/edit/issues/172#issuecomment-2896680778
$DNF_CMD install -y libicu-devel