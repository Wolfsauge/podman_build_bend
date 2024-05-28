# podman_build_bend

This repo contains scripts for building Docker images of HigherOrderCO's [Bend](https://github.com/HigherOrderCO/Bend/).

## Docker Image Tags

### Stable Image
* `docker pull docker.io/nschle/bend:12.4.1-runtime-ubuntu22.04-stable`
    * built with crates.io versions of HVM and Bend
    * [![stable:Docker Image CI](https://github.com/Wolfsauge/podman_build_bend/actions/workflows/docker-image-ci-stable.yaml/badge.svg)](https://github.com/Wolfsauge/podman_build_bend/actions/workflows/docker-image-ci-stable.yaml) 

### Latest Image
* `docker pull docker.io/nschle/bend:12.4.1-runtime-ubuntu22.04-latest`
    * built with git versions of HVM and Bend
    * [![latest:Docker Image CI](https://github.com/Wolfsauge/podman_build_bend/actions/workflows/docker-image-ci-latest.yaml/badge.svg)](https://github.com/Wolfsauge/podman_build_bend/actions/workflows/docker-image-ci-latest.yaml) 

### Build Notes
* this build is based on the Ubuntu images provided by [Nvidia](https://hub.docker.com/r/nvidia/cuda)
   * docker.io/nvidia/cuda:12.4.1-devel-ubuntu22.04 (sha256:5645fec64549cc35930eee9d85aafd2b0006c0c3f22632be5a1d85e2604e9749)
   * docker.io/nvidia/cuda:12.4.1-runtime-ubuntu22.04 (sha256:cff3a0d82d2c2b47bab252d67fa9b34a20ef4c50781d98501b5c7367ea9afd10)
* the Dockerfiles use a 2-stage build
    * hvm and bend-lang are built with the CUDA devel image
    * hvm and bend-lang are then copied to the CUDA runtime image
    * thus nvcc is _not_ included in the final image
* this build aims to produce a small image: ~ 2.6 GB compressed

All stages of the image have SBOM and provenance attestation manifests attached.

## Docker Hub Container Image Library

* [Docker Hub Container Image Library](https://hub.docker.com/repository/docker/nschle/bend/)

## Example Usage

In order to use the stable image with podman and an Nvidia GPU, the following commands can be used.

```shell
$ podman run \
    --replace \
    --device nvidia.com/gpu=all \
    --name=bend \
    --ipc=host \
    -dit \
    docker.io/nschle/bend:12.4.1-runtime-ubuntu22.04-stable
```

```shell
$ podman container exec -it bend bash 
```
