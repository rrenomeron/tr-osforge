just := just_executable()

# Build the tr-osforge container locally
build:
    podman build -t localhost/tr-osforge:latest -f ./Containerfile .

check:
    #!/usr/bin/bash
    find . -type f -name "*.just" | while read -r file; do
      echo "Checking syntax: $file"
      {{ just }} --unstable --fmt --check -f $file
    done
    echo "Checking syntax: Justfile"
        {{ just }} --unstable --fmt --check -f Justfile

fix:
    #!/usr/bin/bash
    find . -type f -name "*.just" | while read -r file; do
      echo "Fixing syntax: $file"
      {{ just }} --unstable --fmt -f $file
    done
    echo "Fixing syntax: Justfile"
    {{ just }} --unstable --fmt -f Justfile || { exit 1; }

# Inspect the directory structure of an OCI image
tree IMAGE="localhost/tr-osforge:latest":
    echo "FROM alpine:latest" > TreeContainerfile
    echo "RUN apk add --no-cache tree" >> TreeContainerfile
    echo "COPY --from={{ IMAGE }} / /mnt/root" >> TreeContainerfile
    echo "CMD tree /mnt/root" >> TreeContainerfile
    podman build -t tree-temp -f TreeContainerfile .
    podman run --rm tree-temp
    rm TreeContainerfile
    podman rmi tree-temp