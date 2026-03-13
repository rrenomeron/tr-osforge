#!/usr/bin/bash

get_base_os() {
    ALMA_VERSION=$(rpm -E %almalinux)
    FEDORA_VERSION=$(rpm -E %fedora)
    RHEL_VERSION=$(rpm -E %rhel)
    CENTOS_VERSION=$(rpm -E %centos)
    if [ "$FEDORA_VERSION" != "%fedora" ]; then
        export BASE_OS_TYPE="fedora"
        export BASE_OS_VERSION="$FEDORA_VERSION"
        return
    elif [ "$ALMA_VERSION" != "%almalinux" ]; then
        export BASE_OS_TYPE="almalinux"
        export BASE_OS_VERSION="$ALMA_VERSION"
        return
    elif [ "$CENTOS_VERSION" != "%centos" ]; then
        export BASE_OS_TYPE="centos"
        export BASE_OS_VERSION="$CENTOS_VERSION"
        return
    elif [ "$RHEL_VERSION" != "%rhel" ]; then
        export BASE_OS_TYPE="rhel"
        export BASE_OS_VERSION="$RHEL_VERSION"
        return
    else
        export BASE_OS_TYPE="unknown"
        export BASE_OS_VERSION="unknown"
    fi
}