#!/usr/bin/bash

set -eoux pipefail
source /ctx/oci/tr-osforge/build/helpers/utils.sh

$DNF_CMD install -y \
    patch \
    pcsc-utils \
    nethogs