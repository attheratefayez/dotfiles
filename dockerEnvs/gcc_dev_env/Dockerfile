FROM gcc:latest

# Basic Installs
RUN apt-get update && apt upgrade -y \
    && apt-get install -y \
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
    npm \
    ninja-build \
    openssh-server \
    pkg-config \
    python3 \
    python3-venv \
    ripgrep \
    stow \
    sudo \
    tmux \ 
    vim \
    xclip \
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
RUN groupadd --gid $UID $USER \
    && useradd -s /bin/bash --uid $UID --gid $UID -m $USER \
    && mkdir /home/$USER/.config && chown $USER:$UID /home/$USER/.config \
    && mkdir $XDG_RUNTIME_DIR && chown $USER:$UID $XDG_RUNTIME_DIR \
    && echo $USER ALL=\(ALL\) NOPASSWD: ALL > /etc/sudoers.d/$USER \
    && chmod 0440 /etc/sudoers.d/$USER

SHELL ["/bin/bash", "-c"]
WORKDIR /home/$USER

USER $USER 

# installing fzf    
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install --completion --no-key-bindings --no-update-rc --no-zsh --no-fish
# installing uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# get dotfiles 
RUN (mkdir dotfiles && cd dotfiles && git clone https://github.com/attheratefayez/dotfiles.git .) \
    && (rm .bashrc && cd dotfiles && stow . && source ./../.bashrc && source /etc/profile.d/bash_completion.sh) 

# get tpm
RUN git clone https://github.com/tmux-plugins/tpm /home/$USER/.tmux/plugins/tpm

# get nerd font : FiraCode
RUN (mkdir -p /home/$USER/.local/share/fonts \
    && cd /home/$USER/.local/share/fonts \
    && wget -O firacode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip \
    && unzip firacode.zip -d firacode && mv ./firacode/*-Regular.ttf ./ && rm -rf firacode.zip firacode)

# install neovim
RUN curl -fL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz -o nvim-linux-x86_64.tar.gz \
    && tar -xzvf nvim-linux-x86_64.tar.gz \
    && sudo mkdir /opt/nvim/ && sudo mv nvim-linux-x86_64/* /opt/nvim/ \
    && sudo ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim \
    && rm -rf nvim-linux-x86_64 nvim-linux-x86_64.tar.gz 

#install alacritty
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y \
    && source $HOME/.cargo/env && cargo install alacritty \
    && sudo rm -rf /var/lib/apt/lists/*

# to build the image
# docker image build --build-arg UID=$UID --build-arg USER=$USER -t gcc_dev_env .

# to make a container 
# docker run -it --name sfml_cont --hostname sfml_cont.uatech --user $USER \
# --volume /tmp/.X11-unix:/tmp/.X11-unix:rw --env=DISPLAY \
# --volume /usr/share/fonts:/usr/share/fonts \
# --volume /home/$USER/Bugs/Rosjects/:/home/$USER/Bugs/Rosjects:rw \
# --runtime nvidia --gpus all gcc_dev_env 

# docker run -it --name sfml_cont --hostname sfml_cont.uatech \
# --volume /tmp/.X11-unix:/tmp/.X11-unix:rw --env=DISPLAY   \
# --volume /usr/share/fonts/:/usr/share/fonts   \
# --volume /home/re/Bugs/Rosjects/:/home/re/Bugs/Rosjects:rw   \
# --device /dev/video0   \
# --device /dev/video1   \
# --device /dev/video2   \
# --device /dev/video3   \
# --device /dev/video4  \
# --device /dev/video5 \
# --device /dev/media0 \
# --device /dev/media1 \
# --volume /sys:/sys  \
# --runtime nvidia --gpus all gcc_dev_env
