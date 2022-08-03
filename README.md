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
You can download the image and run it first time with oneliner:

```console
curl -sL | bash
```

Dockerimage contains all required runtime dependencies.
For making saved data to be persisted even if the image is removed, named volume is used.
By default, PoB and saved data has been installed into the `volume` named as `pathofbuilding`.
This happens when you run the usage script first time.

On second run, the volume is detected and already installed binary is executed, and PoB can be used.

# Licence

MIT




