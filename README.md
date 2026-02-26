# bionf_utilities

## HOW TO USE

1. Pull the image
The docker image can be pulled from [Docker Hub](https://hub.docker.com/r/trvinh/bionf_utilities) using this command
```
docker pull trvinh/bionf_utilities
```

2. Run the container

```
docker run --platform linux/amd64 -it trvinh/bionf_utilities
```

or run the container using Docker Desktop dashboard and open CLI.

3. Stop the container

First, get the list of all containers
```
docker ps -a
```

Then, stop the corresponding container using its ID

```
docker stop <container_id>
```

4. Remove the container (if you no longer need it)

```
docker rm <container_id>
```

5. Remove the image (to free disk space)

First, get the image ID

```
docker image ls
```

Then, remove the image using it ID

```
docker rmi <image_id>
```

## HOW TO MAINTAIN THE IMAGE

1. Clone or fork this repo

2. Make changes for these files: Dockerfile, dependencies.txt and tools.txt

3. Build the image
```
docker build . -t trvinh/bionf_utilities[:0.1.2] --platform linux/amd64 --progress=plain
```

_**Note**: you need to replace <kbd>trvinh</kbd> by your Docker Username. <kbd>:0.1.2</kbd> specifies the TAG of your build (if empty, the default tag <kbd>latest</kbd> will be applied)_

4. Push to Docker Hub
```
docker push trvinh/bionf_utilities[:0.1.2]
```

__Check this [document](https://docs.docker.com/docker-hub/repos/) for more info!__

5. Make sure to clean build caches after pushing

Use this command to see how large is the cache
```
docker system df
```

and run this to free the disk space

```
docker buildx prune
```

## TOOLS included

* [FAS](https://github.com/BIONF/FAS)
* [fDOG](https://github.com/BIONF/fDOG)
* [fCAT](https://github.com/BIONF/fCAT)

Those tools can be used directly without running the setup of each tool. For example:

```
# FAS annotation
fas.doAnno -i test_annofas.fa -o test_fas

# fDOG
fdog.run --seqFile infile.fa --jobName test --refspec HUMAN@9606@qfo24_02
```
