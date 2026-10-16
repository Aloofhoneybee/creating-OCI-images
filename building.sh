#!/bin/bash

set -euo pipefail

ROOTFS=rootfs
OUTPUT=myimage
TAG=latest

container=$(buildah from scratch)

buildah copy "$container" "$ROOTFS/." /

buildah config --os linux --arch amd64 "$container"

buildah commit "$container" "oci:$OUTPUT:$TAG"

buildah rm "$container"
