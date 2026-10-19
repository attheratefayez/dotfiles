FROM osrf/ros:jazzy-desktop-full

# Basic Installs
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash-completion \
    build-essential \
    cmake \
    clang \
    curl \
    gcc \
    gdb \
    gettext \
    git \
    libxkbcommon-x11-0 \
    locales \
    libfreetype6-dev \
    libfontconfig1-dev \
    libxcb-xfixes0-dev \
    libxkbcommon-dev \
    make \
    ninja-build \
    pkg-config \
    python3 \
    python3-venv \
    ripgrep \
    stow \
    sudo \
    tmux \
    vim \
    wl-clipboard \
    zoxide \
    unzip 
    
ARG UID 
ARG USER

ENV USER=$USER
ENV HOME=/home/$USER
ENV XDG_RUNTIME_DIR=/run/user/$UID
ENV LANG=en_US.UTF-8

RUN sed -i 's/^# *en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8

# Adding user and createing home and adding user to sudoers group
RUN echo $USER ALL=\(ALL\) NOPASSWD: ALL > /etc/sudoers.d/$USER \
    && chmod 0440 /etc/sudoers.d/$USER \
    && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]
WORKDIR /home/$USER

USER $USER 

# installing fzf    
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install --completion --no-key-bindings --no-update-rc --no-zsh --no-fish


# get dotfiles 
RUN (mkdir dotfiles && cd dotfiles && git clone https://github.com/attheratefayez/dotfiles.git .) \
    && (rm .bashrc && cd dotfiles && stow . && source ./../.bashrc && source /etc/profile.d/bash_completion.sh) 

# get tpm
RUN git clone https://github.com/tmux-plugins/tpm /home/$USER/.tmux/plugins/tpm


# install neovim (nightly)
RUN curl -fL https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz -o nvim-linux-x86_64.tar.gz \
    && tar -xzvf nvim-linux-x86_64.tar.gz \
    && sudo mkdir -p /opt/nvim/ && sudo mv nvim-linux-x86_64/* /opt/nvim/ \
    && sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim \
    && rm -rf nvim-linux-x86_64 nvim-linux-x86_64.tar.gz


#install alacritty
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y \
    && source $HOME/.cargo/env && cargo install alacritty tree-sitter-cli

#install opencode
RUN curl -fsSL https://opencode.ai/v2/install | bash
RUN /home/$USER/.opencode/bin/opencode plugin add @dietrichgebert/ponytail

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.8/install.sh | bash \
    && \. "$HOME/.nvm/nvm.sh"\
    && nvm install 24

RUN . "$HOME/.nvm/nvm.sh" \
    && git clone --depth 1 https://github.com/affaan-m/ECC.git\
    && cd ECC\
    && npm install && npm run build:opencode && ./install.sh --profile full --target opencode --enable-hooks\
    && cd && rm -rf ECC

# docker image build --build-arg UID=$UID --build-arg USER=$USER -t ros_dev_env .
