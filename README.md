# bionf_utilities

## BUILD
docker build . -t trvinh/bionf_utilities --platform linux/amd64 --progress=plain

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
First need to source the bashrc file
```
source /root/.bashrc
```

Then all the commands of FAS, fDOG, fCAT, etc. can be used without running setup of each tool.
