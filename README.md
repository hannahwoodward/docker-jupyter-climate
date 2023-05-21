# Jupyter & Climate Docker Image

[Docker](https://www.docker.com/)/[Podman](https://podman.io/) image to load [Jupyter](https://docs.jupyter.org/en/latest/) and [Conda](https://docs.conda.io/en/latest/), with a few [additional packages](Dockerfile) useful for climatological data analysis. For an image with some additional packages useful for Earth climate science, see [hannahwoodward/docker-jupyter-climate-earth](https://github.com/hannahwoodward/docker-jupyter-climate-earth)


## Useful links

* [Jupyter Docker stacks github](https://github.com/jupyter/docker-stacks)
* [Jupyter Docker stacks docs](https://jupyter-docker-stacks.readthedocs.io/en/latest/index.html)
* [Docker build help](https://docs.docker.com/engine/reference/commandline/build/)
* [Docker run help](https://docs.docker.com/engine/reference/commandline/run/)


## Installation & Use

* [Install Docker desktop](https://www.docker.com/get-started)
* Ensure Docker desktop is running
* Navigate to your project directory (i.e. with Jupyter notebook files)
* Download published image:

```
docker pull woodwardsh/jupyter-climate:latest
```

* Run published image, mounting local working directory to container directory `/home/jovyan`:

```
docker run -it --rm -p 8888:8888 -v ${PWD}:/home/jovyan -w /home/jovyan woodwardsh/jupyter-climate:latest

# Options:
# -it           interactive && TTY (starts shell inside container)
# --rm          delete container on exit
# --volume|-v   mount local directory inside container
# -w PATH       sets working directory inside container
```


### Podman

* Podman requires additional arguments to enable volume mounting with correct permissions (see [podman run](https://docs.podman.io/en/latest/markdown/podman-run.1.html), nb `:Z|z` is not supported in macOS ):

```
podman run -it --rm -p 8888:8888 --userns=keep-id -v ${PWD}:/home/jovyan:z -w /home/jovyan woodwardsh/jupyter-climate
```


## Exporting the Conda environment

* Start the container
* Open a new terminal inside JupyterLab
* Run `sh ~/generate-config.sh` to generate config `climate.yml` into your working directory
* Download `climate.yml` from the JupyterLab UI, or copy straight from the directory if mounted


## Building & running image from scratch

* Clone repo & navigate inside:

```
git clone git@github.com:hannahwoodward/docker-jupyter-climate.git && cd docker-jupyter-climate
```

* Build image from Dockerfile (takes ~15 minutes):

```
docker build -t jupyter-climate .

# -t = name/tag the image, format `name:tag`
```

* Navigate to your project directory (i.e. with Jupyter notebook files)
* Run locally built image, mounting local working directory to container directory `/home/jovyan`:

```
docker run -it --rm -p 8888:8888 -v ${PWD}:/home/jovyan -w /home/jovyan jupyter-climate

# Options:
# -it           interactive && TTY (starts shell inside container)
# --rm          delete container on exit
# --volume|-v   mount local directory inside container
# -w PATH       sets working directory inside container
```


## Publishing image

```
docker login && docker tag jupyter-climate woodwardsh/jupyter-climate && docker push woodwardsh/jupyter-climate
```


## Troubleshooting

* Exit code 137 - need to increase Docker memory e.g. to 4GB
* No space left on device - `docker system prune`
