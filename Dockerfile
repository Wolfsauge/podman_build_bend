FROM docker.io/nvidia/cuda:12.4.1-devel-ubuntu22.04 as devel-000

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    ca-certificates \
    python3.11 \
    python3-pip \
    git \
    ssh \
    7zip \
    iputils-ping \
    git-lfs \
    less \
    net-tools \
    nvi \
    nvtop \
    rsync \
    tmux \
    unzip \
    vim \
    wget \
    zip \
    zsh \
    && rm -rf /etc/ssh/ssh_host_*

# Set locale
RUN apt-get install -y locales && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# Upgrade
RUN apt-get upgrade -y

# Install dumb-init
RUN apt-get install -y dumb-init

# Change global Python
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 \
    && apt-get install -y --no-install-recommends python-is-python3 \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --no-cache-dir --upgrade pip

# Set up git to support LFS, and to cache credentials; useful for Huggingface Hub
RUN git config --global credential.helper cache && \
    git lfs install

# Do the build
WORKDIR /workspace

# Get rust nightly via rustup
ENV RUSTUP_HOME=/opt/rust
ENV CARGO_HOME=/opt/rust
RUN curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | \
    sh -s -- -y --no-modify-path --profile default --default-toolchain nightly
ENV PATH="/opt/rust/bin:${PATH}"
RUN echo -e '\nPATH="/opt/rust/bin:${PATH}"' >> /etc/profile.d/rust.sh

# Install HVM
RUN cargo +nightly install hvm

# Install bend-lang
RUN cargo +nightly install bend-lang

# First stage done, switch to the runtime image
FROM docker.io/nvidia/cuda:12.4.1-runtime-ubuntu22.04 as runtime-000

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    ca-certificates \
    python3.11 \
    python3-pip \
    git \
    ssh \
    7zip \
    iputils-ping \
    git-lfs \
    less \
    net-tools \
    nvi \
    nvtop \
    rsync \
    tmux \
    unzip \
    vim \
    wget \
    zip \
    zsh \
    && rm -rf /etc/ssh/ssh_host_*

# Set locale
RUN apt-get install -y locales && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# Upgrade
RUN apt-get upgrade -y

# Install dumb-init
RUN apt-get install -y dumb-init

# Change global Python
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 \
    && apt-get install -y --no-install-recommends python-is-python3 \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --no-cache-dir --upgrade pip

# Set up git to support LFS, and to cache credentials; useful for Huggingface Hub
RUN git config --global credential.helper cache && \
    git lfs install

# Set workdir (otherwise empty mount point for disk volume in RunPod) 
WORKDIR /workspace

# Copy artifacts
COPY --from=devel-000 /opt /opt

# Setup runtime rust nightly environment with previously built artifacts
ENV RUSTUP_HOME=/opt/rust
ENV CARGO_HOME=/opt/rust
ENV PATH="/opt/rust/bin:${PATH}"
RUN echo -e '\nPATH="/opt/rust/bin:${PATH}"' >> /etc/profile.d/rust.sh

# Make port 22 available to the world outside this container
EXPOSE 22

# Set the entry point
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# Run when the container launches
CMD ["sleep", "infinity"]
