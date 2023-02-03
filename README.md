# bionf_utilities

## BUILD
```
docker build . -t trvinh/bionf_utilities --platform linux/amd64 --progress=plain
```

## PULL
The docker image can be pulled from dockerhub using this command
```
docker pull trvinh/bionf_utilities
```

## RUN

```
docker run -it trvinh/bionf_utilities
```

or run the image using Docker Desktop dashboard and open CLI.

## USAGE

FAS, fDOG, fCAT, etc. can be used without running the setup of each tool. For example:

```
fas.doAnno -i test_annofas.fa -o test_fas
fdog.run --seqFile infile.fa --jobName test_fdog --refspec HUMAN@9606@3
```
