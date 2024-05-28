# podman_build_bend

This repo contains scripts for building Docker images of HigherOrderCO's [Bend](https://github.com/HigherOrderCO/Bend/).

## Docker Image Tags

* `docker pull docker.io/nschle/bend:12.4.1-runtime-ubuntu22.04-stable`
 * built with crates.io versions of HVM and Bend
 * [![stable:Docker Image CI](https://github.com/Wolfsauge/podman_build_bend/actions/workflows/docker-image-ci-stable.yaml/badge.svg)](https://github.com/Wolfsauge/podman_build_bend/actions/workflows/docker-image-ci-stable.yaml) 

* `docker pull docker.io/nschle/bend:12.4.1-runtime-ubuntu22.04-latest`
 * built with git versions of HVM and Bend
 * [![latest:Docker Image CI](https://github.com/Wolfsauge/podman_build_bend/actions/workflows/docker-image-ci-latest.yaml/badge.svg)](https://github.com/Wolfsauge/podman_build_bend/actions/workflows/docker-image-ci-latest.yaml) 

 * nvcc is _not_ provided in the image
 * small image: ~ 3 GB compressed
 * 2-stage build: bend is built with the devel image, then copied to the runtime image
 * based on [Nvidia CUDA Ubuntu 22.04](https://hub.docker.com/r/nvidia/cuda) (12.4.1-devel-ubuntu22.04 and 12.4.1-runtime-ubuntu22.04)

All stages of the image have SBOM and provenance attestation manifests attached.

## Docker Hub Container Image Library

* [Docker Hub Container Image Library](https://hub.docker.com/repository/docker/nschle/bend/)

## Example Usage

```shell
$ podman run \
    --replace \
    --device nvidia.com/gpu=all \
    --name=bend \
    --ipc=host \
    -dit \
    docker.io/nschle/bend:12.4.1-runtime-ubuntu22.04-latest
```

```shell
$ podman container exec -it bend bash 
```
