# bootc-layers

## Usage

You can use these layers to build up your own custom image for use with BOOTC.

Tag one layer and use it as the BASE of the next layer until you have your final assembly.

Example:
```
BASEREPO=yourrepo/bootc-image
podman build -t $BASEREPO:spire-agent spire-agent/ --build-arg=BASE=$START
podman build -t $BASEREPO:spire-server spire-server/ --build-arg=BASE=$BASEREPO:spire-agent
podman build -t $BASEREPO:latest cloud-init/ --build-arg=BASE=$BASEREPO:spire-server
podman push $BASEREPO:latest
```
