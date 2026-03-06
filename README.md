[![Docker Pulls](https://img.shields.io/docker/pulls/trvinh/bionf_utilities)](https://hub.docker.com/r/trvinh/bionf_utilities)
[![Docker Image Size](https://img.shields.io/docker/image-size/trvinh/bionf_utilities/latest)](https://hub.docker.com/r/trvinh/bionf_utilities)
[![Docker Version](https://img.shields.io/docker/v/trvinh/bionf_utilities)](https://hub.docker.com/r/trvinh/bionf_utilities)

# bionf_utilities

Docker image that packages several tools developed by the [BIONF](https://github.com/BIONF) group into a **single portable and reproducible environment**.

The container allows users to run these tools **without manually installing dependencies**, making it suitable for:

- local development
- reproducible research
- HPC environments
- cloud platforms (e.g. AWS)

Currently included tools:

- [FAS](https://github.com/BIONF/FAS)
- [fDOG](https://github.com/BIONF/fDOG)
- [fCAT](https://github.com/BIONF/fCAT)
- [DCC2](https://github.com/BIONF/dcc2)

---

# Table of Contents

- [bionf_utilities](#bionf_utilities)
- [Table of Contents](#table-of-contents)
- [Requirements](#requirements)
- [Quick Start](#quick-start)
- [Using Apptainer (recommended)](#using-apptainer-recommended)
- [Using Docker](#using-docker)
- [How to Maintain the Image](#how-to-maintain-the-image)
- [Testing Using AWS](#testing-using-aws)

---

# Requirements

You need **one** of the following container runtimes:

- [Apptainer](https://apptainer.org) (recommended for Linux and HPC systems)
- [Docker](https://www.docker.com)

---

# Quick Start

Pull the container and run a BIONF tool immediately.

### Docker

```
docker pull trvinh/bionf_utilities
docker run --platform linux/amd64 -it trvinh/bionf_utilities
```

Example:

```
fas.doAnno -i test_annofas.fa -o test_fas
```

### Apptainer

```
apptainer pull docker://trvinh/bionf_utilities:latest
apptainer exec -e bionf_utilities_latest.sif fas.doAnno -i test_annofas.fa -o test_fas

```

---

# Using Apptainer (recommended)

**Note: for Linux only**

Apptainer is recommended for HPC clusters because it allows users to run containers without requiring root privileges.

## 1 Install Apptainer

Example installation using [mamba](https://mamba.readthedocs.io/en/latest/):

```
mamba create -n apptainer apptainer
mamba activate apptainer

```
## 2 Pull the container image

```
apptainer pull docker://trvinh/bionf_utilities:latest

```

This command downloads the Docker image and converts it into an Apptainer image file:

```
bionf_utilities_latest.sif

```

## 3 Run BIONF tools

General syntax:

```
apptainer exec -e bionf_utilities_latest.sif <command>

```

Example:

*FAS annotation*

```
fas.doAnno -i test_annofas.fa -o test_fas

```

*fDOG*

```
fdog.run --seqFile infile.fa --jobName test --refspec HUMAN@9606@qfo24_02

```

---

# Using Docker

## 1 Pull the image

The image is hosted on Docker Hub:

https://hub.docker.com/r/trvinh/bionf_utilities

Pull it using:

```

docker pull trvinh/bionf_utilities

```

## 2 Run the container

```

docker run --platform linux/amd64 -it trvinh/bionf_utilities

```

Alternatively, you can run the container using the **Docker Desktop dashboard** and open a CLI session.

Once inside the container, the BIONF tools can be used directly.

Example:

*FAS annotation*

```
fas.doAnno -i test_annofas.fa -o test_fas

```

*fDOG*

```
fdog.run --seqFile infile.fa --jobName test --refspec HUMAN@9606@qfo24_02

```

---

## 3 Stopping and Removing Containers

- List containers

```
docker ps -a

```

- Stop a container

```
docker stop <container_id>

```

- Remove a container

```
docker rm <container_id>

```

---

## 4 Removing the Image

To free disk space you can remove the Docker image.

- List images

```
docker image ls

```

- Remove image

```
docker rmi <image_id>

```

---

# How to Maintain the Image

Follow these steps if you want to modify or rebuild the container.

## 1 Clone or fork the repository

```
git clone <repository_url>
cd bionf_utilities

```

## 2 Modify configuration files

Update the following files as needed:

```
Dockerfile
dependencies.txt
tools.txt

```

These files define:

- installed dependencies
- installed BIONF tools
- container configuration

## 3 Build the image

```
docker build . -t trvinh/bionf_utilities[:0.1.2] --platform linux/amd64 --progress=plain

```

Notes:

- Replace `trvinh` with your **Docker Hub username**.
- `:0.1.2` defines the **image tag**.
- If no tag is provided, Docker automatically assigns the `latest` tag.

## 4 Push the image to Docker Hub

```
docker push trvinh/bionf_utilities[:0.1.2]

```

More details are available in the Docker documentation:

https://docs.docker.com/docker-hub/repos/

## 5 Clean build cache

Check disk usage:

```
docker system df

```

Remove unused build cache:

```
docker buildx prune

```

This helps free disk space after building and pushing images.

---

# Testing Using AWS

Instructions for testing this container on AWS can be found here:

https://gist.github.com/trvinh/475f66d40e13dddcb9a40292c8892d93
