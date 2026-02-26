FROM mambaorg/micromamba:latest

# Use root user for system setup
USER root

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Berlin \
    MAMBA_ROOT_PREFIX=/opt/micromamba \
    PATH="/opt/micromamba/bin:$PATH"

WORKDIR /usr/src/app

# Install essential system utilities
RUN apt-get update -yq && \
    apt-get upgrade -yq && \
    apt-get install -yq wget curl less nano git build-essential gcc && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Firefox (or another lightweight browser) if needed
RUN apt-get update && apt-get install -y firefox-esr && rm -rf /var/lib/apt/lists/*

# Set R browser
ENV R_BROWSER=firefox
RUN echo 'options(browser="firefox")' >> /root/.Rprofile

# Create necessary directories before changing ownership
RUN mkdir -p /usr/src/app /usr/data /opt/micromamba
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Create a new non-root user (bionf_user) and set permissions
RUN useradd -ms /bin/bash bionf_user && \
    chown -R bionf_user:bionf_user /usr/src/app /usr/data /opt/micromamba

# Switch to bionf_user for installing tools and running setups
USER bionf_user

# Create and activate a Micromamba environment with Python and R
RUN micromamba create -y -n bionf_env python=3.12 r-base=4.4.3 && \
    echo "micromamba activate bionf_env" >> ~/.bashrc

# Set COILSDIR environment variable
RUN echo 'export COILSDIR=/usr/data/annotation_tools/COILS2/coils' >> /opt/micromamba/envs/bionf_env/etc/conda/activate.d/env_vars.sh

# Ensure the environment is activated by default
ENV PATH="/opt/micromamba/envs/bionf_env/bin:$PATH"

# Copy tools and dependencies files
COPY --chown=bionf_user:bionf_user dependencies.txt /usr/data/

# Install rpy2 using conda to avoid error of installing dcc2
RUN micromamba run -n bionf_env micromamba install conda-forge::rpy2

# Install Python tools inside the environment
RUN micromamba run -n bionf_env pip install greedyFAS==1.19.4 && \
    micromamba run -n bionf_env pip install fdog==1.1.4 && \
    micromamba run -n bionf_env pip install fcat==0.1.11 && \
    micromamba run -n bionf_env pip install dcc2==0.3.3

# Download and extract licensed tools
RUN mkdir -p /usr/src/app/licensed_tools && \
    wget -qO /usr/src/app/licensed_tools/smart_simplifed.tar.gz https://github.com/BIONF/sharingiscaring/raw/main/licensed_tools/smart_simplifed.tar.gz && \
    wget -qO /usr/src/app/licensed_tools/signalp-4.1g.Linux.tar.gz https://github.com/BIONF/sharingiscaring/raw/main/licensed_tools/signalp-4.1g.Linux.tar.gz && \
    wget -qO /usr/src/app/licensed_tools/tmhmm-2.0c.Linux.tar.gz https://github.com/BIONF/sharingiscaring/raw/main/licensed_tools/tmhmm-2.0c.Linux.tar.gz && \
    for f in /usr/src/app/licensed_tools/*.tar.gz; do tar -xzf "$f" -C /usr/src/app/licensed_tools/; done

# Setup FAS inside the activated environment
WORKDIR /usr/data
RUN micromamba run -n bionf_env fas.setup -t /usr/data/annotation_tools \
  -d /usr/src/app/licensed_tools \
  --smartPath /usr/src/app/licensed_tools/smart_simplifed

# recompile COILS
RUN cd /usr/data/annotation_tools/COILS2/coils && \
    cc -std=gnu89 -O2 -I. -o ncoils-osf ncoils.c read_matrix.c -lm && \
    cd .. && \
    rm -f COILS2 && \
    ln -s coils/ncoils-osf COILS2
ENV COILSDIR=/usr/data/annotation_tools/COILS2/coils

# Setup fDOG inside the activated environment
RUN micromamba run -n bionf_env micromamba install -c conda-forge -c bioconda $(cat /usr/data/dependencies.txt) -y && \
    micromamba clean --all --yes
RUN micromamba run -n bionf_env fdog.setup -d /usr/data/fdog_data

# Install R tools from CRAN
#RUN micromamba run -n bionf_env Rscript -e "install.packages(c('BiocManager', 'xml2', 'mgcv', 'ggplot2', 'colourpicker'), repos='http://cran.r-project.org')"

# Install Bioconductor packages
#RUN micromamba run -n bionf_env Rscript -e "BiocManager::install('PhyloProfile')"
RUN micromamba run -n bionf_env micromamba install bioconda::bioconductor-phyloprofile -y && \
    micromamba clean --all --yes

# Set back non-interactive mode and working directory
WORKDIR /usr/project
ENV DEBIAN_FRONTEND=newt

# Ensure Micromamba environment is activated by default when the container starts
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash", "-c", "eval \"$(micromamba shell hook --shell bash)\" && micromamba activate bionf_env && exec bash"]
