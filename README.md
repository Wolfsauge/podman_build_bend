# podman_build_bend

This repo contains scripts for building images of [HigherOrderCO](https://github.com/HigherOrderCO)'s [HVM](https://github.com/HigherOrderCO/HVM) and [Bend](https://github.com/HigherOrderCO/Bend/).

## Tags

The workflows of this repo push their tags to this [Docker Hub repo](https://hub.docker.com/repository/docker/nschle/bend/).

### Stable Image

* `docker pull docker.io/nschle/bend:12.4.1-runtime-ubuntu22.04-stable`
    * built with crates.io versions of HVM and Bend
    * this image contains the HVM and Bend versions considered stable by the developers
    * [![stable:Docker Image CI](https://github.com/Wolfsauge/podman_build_bend/actions/workflows/docker-image-ci-stable.yaml/badge.svg)](https://github.com/Wolfsauge/podman_build_bend/actions/workflows/docker-image-ci-stable.yaml) 

### Latest Image
* `docker pull docker.io/nschle/bend:12.4.1-runtime-ubuntu22.04-latest`
    * built with the latest git versions of HVM and Bend
    * [![latest:Docker Image CI](https://github.com/Wolfsauge/podman_build_bend/actions/workflows/docker-image-ci-latest.yaml/badge.svg)](https://github.com/Wolfsauge/podman_build_bend/actions/workflows/docker-image-ci-latest.yaml) 

### Build Notes

* based on the CUDA Ubuntu images provided by [Nvidia](https://hub.docker.com/r/nvidia/cuda)
   * docker.io/nvidia/cuda:12.4.1-devel-ubuntu22.04 `sha256:5645fec64549cc35930eee9d85aafd2b0006c0c3f22632be5a1d85e2604e9749`
   * docker.io/nvidia/cuda:12.4.1-runtime-ubuntu22.04 `sha256:cff3a0d82d2c2b47bab252d67fa9b34a20ef4c50781d98501b5c7367ea9afd10`
* nvcc _not_ included in the images
* aiming to produce small images: ~ 2.6 GB compressed
* two-stage build process:
    1. hvm and bend-lang built with CUDA devel image
    2. build artifacts then copied to CUDA runtime image
* SBOM created with syft
* provenance attestation manifests attached

## Example Usage

In order to use the stable image with podman and GPU, the following commands can be used.

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
