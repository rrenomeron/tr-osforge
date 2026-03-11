#!/usr/bin/bash

is_fedora() {
    FEDORA_VERSION=$(rpm -E %fedora)
    if [ "$FEDORA_VERSION" == "%fedora" ]; then
        return 1
    else
        return 0
    fi
}

is_alma() {
    ALMA_VERSION=$(rpm -E %almalinux)
    if [ "$ALMA_VERSION" == "%almalinux" ]; then
        return 1
    else
        return 0
    fi
}