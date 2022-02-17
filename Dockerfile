FROM ubuntu:latest

# Set for all apt-get install, must be at the very beginning of the Dockerfile.
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

WORKDIR /usr/src/app

COPY tools.txt ./
COPY install_lib.sh ./

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update -yq && \
  apt-get upgrade -yq
RUN apt-get install dialog apt-utils -yq
RUN apt-get install -yq python3-pip r-base wget curl less nano

RUN echo 'alias python="/usr/bin/python3"' >> /root/.bashrc && \
  echo 'alias pip="/usr/bin/pip3"' >> /root/.bashrc && \
  source /root/.bashrc

RUN pip install --no-cache-dir --upgrade pip && \
  pip install --no-cache-dir -r tools.txt

WORKDIR /usr/data
RUN fas.setup -t /usr/data/annotation_tools -i SignalP TMHMM && \
  source /root/.bashrc

RUN chmod +x /usr/src/app/install_lib.sh
RUN DEBIAN_FRONTEND=noninteractive /usr/src/app/install_lib.sh
RUN fdog.setup -o /usr/data/fdog_data

# Non-interactive modes get set back.
ENV DEBIAN_FRONTEND newt
