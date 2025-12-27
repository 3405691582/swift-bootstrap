# swift-bootstrap

This repository contains Containerfiles to build OCI scratch containers
that contain OpenBSD binary packages for the Swift toolchain.

The Swift port may use the GitHub Releases functionality to obtain a
prebuilt toolchain for bootstrapping.

## Usage

To build these containers, you will need to either build or pull either
the `openbsd-amd64` or `openbsd-arm64` images as necessary from
[1f421](https://github.com/3405691582/1f421) first.

The port will be built during the package build process. These packages
can be used to bootstrap future port builds. This build can consume
a large amount of time and disk space during the build. Using KVM
on the build host is recommended. Note that partial builds will not
be resumed if interrupted.

You should tune the CPU and MEM environment variables to suit your build
host. These are the verbatim qemu arguments, e.g., during build, use
flags `--build-arg CPU=2 --build-arg MEM=4G` for a constrained machine.

You must specify an additional build context named `port` that includes
the path that contains `port.diff`, e.g., if your working directory
is the same as the Containerfile, then the additional argument you
will need will look like `--build-context=port=../../`

## Caveats

Error handling is not handled fully yet and may result in empty
containers being built incorrectly. Due to hardware limitations, these
container builds have not been fully tested yet.
