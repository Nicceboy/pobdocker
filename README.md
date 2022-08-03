# Path of Building in Docker

Since Path of Exile is gloriously working under Linux systems in these days, some might want to run [Path of Building](https://github.com/PathOfBuildingCommunity/PathOfBuilding) under Linux as well.
Path of Building is mainly intended for Windows systems, but it works well under [wine](https://www.winehq.org/).
However, the process for making it work, or using regularly might be sometimes laborious.
Or one might rather keep their host system clean and easily controllable.

This repository contains Dockerfile and short instructions for using it straightforwardly.
It hopefully works in any Linux distribution.
Only Docker daemon is required.

## Usage

Usage requires Docker image and a set of parameters for running the Docker container.
Dockerimage contains all required runtime dependencies.
You can download the image and run it first time with oneliner (See [script contents](https://github.com/Nicceboy/pobdocker/blob/main/pob).):

```console
curl -sL https://raw.githubusercontent.com/Nicceboy/pobdocker/main/pob > pob && bash pob
```
On first time, it will prompt for installation of PoB .
For making saved data to be persisted even if the image is removed, named volume is used.
On second run, the volume is detected and already installed binary is executed, and PoB can be used.

To install the script for making usable everywhere, for example just move it to `/usr/local/bin/
The script was downloaded into current directory with the previous oneliner.

```console
sudo mv pob /usr/local/bin/
```

# Details

By default, PoB and saved data has been installed into the `volume` named as `pathofbuilding`.

You can remove the volume with:

```console
docker volume rm pathofbuilding
```

To remove the image:
```console
docker image rm ghcr.io/nicceboy/pobdocker
```

# Troubleshooting

Wayland users might have problems if UID of the current user is not 1000.
Container image should be rebuild to match the UID of the current user to allow using the X11-unix socket for display to work.

# Licence

MIT




