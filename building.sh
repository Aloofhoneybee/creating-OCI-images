#!/bin/bash

set -euo pipefail

ROOTFS=rootfs
OUTPUT=myimage
TAG=latest


checkRootless(){
    if [ "$EUID" -eq 0 ]; then
        echo "Error: don’t run this as root or with sudo. Run it as your normal user.">&2
        exit 1
    else
        echo "Running as user (rootless mode)."
    fi
    
   if ! command -v buildah >/dev/null 2>&1; then
    echo "Error: buildah is not installed." >&2
    exit 1
    fi

  if ! buildah unshare true; then
    echo "Error: 'buildah unshare true' failed — rootless namespaces are not usable." >&2
    exit 1
fi        
}

checkRootless

container=$(buildah from scratch)

buildah copy "$container" "$ROOTFS/." /

buildah config --os linux --arch amd64 "$container"

buildah commit "$container" "oci:$OUTPUT:$TAG"

buildah rm "$container"
