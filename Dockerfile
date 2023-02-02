FROM ubuntu:latest

# Set for all apt-get install, must be at the very beginning of the Dockerfile.
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

WORKDIR /usr/src/app

# Copy required tools and dependencies files
COPY tools.txt ./
COPY dependencies.txt ./
ADD https://github.com/BIONF/sharingiscaring/raw/main/licensed_tools/smart_simplifed.tar.gz /usr/src/app/licensed_tools/
ADD https://github.com/BIONF/sharingiscaring/raw/main/licensed_tools/signalp-4.1g.Linux.tar.gz /usr/src/app/licensed_tools/
ADD https://github.com/BIONF/sharingiscaring/raw/main/licensed_tools/tmhmm-2.0c.Linux.tar.gz /usr/src/app/licensed_tools/
RUN tar -xzf /usr/src/app/licensed_tools/smart_simplifed.tar.gz -C /usr/src/app/licensed_tools/


# Install some essential system tools
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update -yq && \
  apt-get upgrade -yq
RUN apt-get install dialog apt-utils -yq
RUN apt-get install -yq python3-pip r-base wget curl less nano git

# Install dependencies from file
RUN xargs apt-get install -y <dependencies.txt

# Make alias for python3 and pip3
RUN echo 'alias python="/usr/bin/python3"' >> /root/.bashrc && \
  echo 'alias pip="/usr/bin/pip3"' >> /root/.bashrc && \
  source /root/.bashrc

# Install python tools
RUN pip install --no-cache-dir --upgrade pip && \
  pip install --no-cache-dir -r tools.txt

# Setup FAS
WORKDIR /usr/data
RUN fas.setup -t /usr/data/annotation_tools \
  -d /usr/src/app/licensed_tools \
  --smartPath /usr/src/app/licensed_tools/smart_simplifed && \
  source /usr/data/annotation_tools/fas.profile

# Setup fDOG
# RUN DEBIAN_FRONTEND=noninteractive /usr/src/app/install_lib.sh
RUN fdog.setup -d /usr/data/fdog_data

# Non-interactive modes get set back.
WORKDIR /usr/project
ENV DEBIAN_FRONTEND newt
