# bionf_utilities

## HOW TO USE

### PULL THE IMAGE
The docker image can be pulled from [Docker Hub](https://hub.docker.com/r/trvinh/bionf_utilities) using this command
```
docker pull trvinh/bionf_utilities
```

### RUN THE CONTAINER

```
docker run -it trvinh/bionf_utilities
```

or run the image using Docker Desktop dashboard and open CLI.

## HOW TO MAINTAIN THE IMAGE

* Clone or fork this repo

* Build the image
```
docker build . -t trvinh/bionf_utilities --platform linux/amd64 --progress=plain
```

_**Note**: you need to replace <kbd>trvinh</kbd> by your Docker Username._

* Push to Docker Hub

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
