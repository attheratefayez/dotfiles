FROM debian:trixie-slim

ARG UID=1000
ARG USER=latex_dev

ENV USER=${USER}
ENV HOME=/home/${USER}
ENV XDG_RUNTIME_DIR=/run/user/${UID}
ENV LANG=en_US.UTF-8

# Basic installs
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash-completion \
    curl \
    dbus-x11 \
    gettext \
    git \
    latexmk \
    locales \
    luarocks \
    make \
    npm \
    python3 \
    python3-venv \
    ripgrep \
    stow \
    sudo \
    texlive-base \
    texlive-bibtex-extra \
    texlive-science \
    texlive-latex-extra \
    tmux \
    vim \
    wget \
    xclip \
    unzip \
    zathura \
    && rm -rf /var/lib/apt/lists/*

# Locale setup
RUN sed -i 's/^# *en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

# Create user
RUN groupadd -g ${UID} ${USER} && \
    useradd -m -s /bin/bash -u ${UID} -g ${UID} ${USER} && \
    mkdir -p /run/user/${UID} && \
    chown -R ${USER}:${USER} /home/${USER} /run/user/${UID} && \
    echo "${USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER} && \
    chmod 0440 /etc/sudoers.d/${USER}

SHELL ["/bin/bash", "-c"]

USER ${USER}
WORKDIR /home/${USER}

# fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
    ~/.fzf/install --completion --no-key-bindings --no-update-rc --no-zsh --no-fish

# uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# dotfiles
RUN mkdir -p ~/dotfiles && \
    git clone --depth 1 https://github.com/attheratefayez/dotfiles.git ~/dotfiles && \
    rm -f ~/.bashrc && \
    cd ~/dotfiles && \
    stow .

# tmux plugin manager
RUN git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Neovim (latest prebuilt binary)
USER root

RUN curl -fsSL \
    https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
    -o /tmp/nvim.tar.gz && \
    mkdir -p /opt && \
    tar -xzf /tmp/nvim.tar.gz -C /opt && \
    ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim && \
    rm -f /tmp/nvim.tar.gz

USER ${USER}

# FiraCode Nerd Font
RUN mkdir -p ~/.local/share/fonts && \
    cd ~/.local/share/fonts && \
    wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip && \
    unzip -j FiraCode.zip "*Regular.ttf" && \
    rm -f FiraCode.zip
