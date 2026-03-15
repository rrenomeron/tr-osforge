#!/usr/bin/bash

set -eoux pipefail

source /ctx/oci/tr-osforge/build/helpers/utils.sh

echo "Installing Docker"

DOCKER_PACKAGES="containerd.io \
    docker-buildx-plugin \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin \
    docker-model-plugin"

if [ "$BASE_OS_TYPE" == "almalinux" ]; then    
    $DNF_CMD config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
else 
    $DNF_CMD config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
fi
sed -i "s/enabled=.*/enabled=0/g" /etc/yum.repos.d/docker-ce.repo

$DNF_CMD -y install --enablerepo=docker-ce-stable $DOCKER_PACKAGES
    
rm /etc/yum.repos.d/docker-ce.repo

echo "Disabling Rootful Docker"

systemctl disable docker.socket
systemctl disable docker.service

echo "done"