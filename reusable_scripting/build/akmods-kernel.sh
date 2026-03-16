#!/usr/bin/bash
set -eoux pipefail


if command -v dnf5; then
    export DNF_CMD=dnf5
else 
    export DNF_CMD=dnf
fi

# Remove Existing Kernel
for pkg in kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra; do
    rpm --erase $pkg --nodeps
done

find /ctx/oci/akmods

$DNF_CMD -y install \
    /ctx/oci/akmods/kernel-rpms/kernel-[0-9]*.rpm \
    /ctx/oci/akmods/kernel-rpms/kernel-core-*.rpm \
    /ctx/oci/akmods/kernel-rpms/kernel-modules-*.rpm   

$DNF_CMD -y install /ctx/oci/akmods/kernel-rpms/kernel-devel-*.rpm

$DNF_CMD versionlock add kernel kernel-devel kernel-devel-matched kernel-core kernel-modules kernel-modules-core kernel-modules-extra


$DNF_CMD -y install \
    /ctx/oci/akmods/rpms/kmods/*framework-laptop*.rpm \
    /ctx/oci/akmods/rpms/common/*framework-laptop*.rpm
$DNF_CMD -y install \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm
$DNF_CMD -y install \
    v4l2loopback /ctx/oci/akmods/rpms/kmods/*v4l2loopback*.rpm \
    /ctx/oci/akmods/rpms/common/*v4l2loopback*.rpm
$DNF_CMD -y remove rpmfusion-free-release rpmfusion-nonfree-release