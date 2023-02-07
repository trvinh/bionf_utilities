# bionf_utilities

## HOW TO USE

1. Pull the image
The docker image can be pulled from [Docker Hub](https://hub.docker.com/r/trvinh/bionf_utilities) using this command
```
docker pull trvinh/bionf_utilities
```

2. Run the container

```
docker run -it trvinh/bionf_utilities
```

or run the image using Docker Desktop dashboard and open CLI.

## HOW TO MAINTAIN THE IMAGE

1. Clone or fork this repo

2. Make changes for these files: Dockerfile, dependencies.txt and tools.txt

3. Build the image
```
docker build . -t trvinh/bionf_utilities:latest --platform linux/amd64 --progress=plain
```

_**Note**: you need to replace <kbd>trvinh</kbd> by your Docker Username. <kbd><:latest></kbd> specifies the TAG of your build_

4. Push to Docker Hub
```
docker push trvinh/bionf_utilities:latest
```

__Check this [document](https://docs.docker.com/docker-hub/repos/) for more info!__

## TOOLS included

* [FAS](https://github.com/BIONF/FAS)
* [fDOG](https://github.com/BIONF/fDOG)
* [fCAT](https://github.com/BIONF/fCAT)

Those tools can be used directly without running the setup of each tool. For example:

```
# FAS annotation
fas.doAnno -i test_annofas.fa -o test_fas

# fDOG
fdog.run --seqFile infile.fa --jobName test_fdog --refspec HUMAN@9606@3
```
