FROM microros/esp-idf-microros 

# Basic Installs
RUN apt-get update && apt upgrade -y \
    && apt-get install -y \
    bash-completion \
    cmake \
    clang \
    gcc \
    git \ 
    make \ 
    npm \
    openssh-server \
    python3-venv \
    stow \
    sudo \
    tmux \ 
    vim \
    xclip \
    fzf \
    ripgrep

ARG UID 
ARG USER
ENV USER=$USER
ENV HOME=/home/$USER
ENV XDG_RUNTIME_DIR=/tmp/runtime-$USER

# Adding user and createing home and adding user to sudoers group
# RUN groupadd --gid $UID $USER \
#     && useradd -s /bin/bash --uid $UID --gid $UID -m $USER \ 
RUN mkdir /home/$USER/.config && chown $USER:$UID /home/$USER/.config 
    # && echo $USER ALL=\(ALL\) NOPASSWD: ALL > /etc/sudoers.d/$USER \
    # && chmod 0440 /etc/sudoers.d/$USER

SHELL ["/bin/bash", "-c"]
WORKDIR /home/$USER

USER $USER 

# Source install neovim and alacritty 
RUN (mkdir dotfiles && cd dotfiles && git clone https://github.com/attheratefayez/dotfiles.git .)\
    && (rm .bashrc && cd dotfiles && stow . && source ./../.bashrc && source /etc/profile.d/bash_completion.sh) \
    && git clone https://github.com/tmux-plugins/tpm /home/$USER/.tmux/plugins/tpm \
    && sudo apt-get install -y ninja-build gettext cmake unzip curl build-essential \
    cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3\
    && sudo rm -rf /var/lib/apt/lists/* 

RUN mkdir gitclones && (cd gitclones \
    && git clone https://github.com/neovim/neovim \
    && cd neovim && git checkout stable \
    && make CMAKE_BUILD_TYPE=Release \
    && sudo make install) 

RUN (curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y\
    && source $HOME/.cargo/env && cargo install alacritty) \
    && rm -rf gitclones



# docker image build --build-arg UID=$UID --build-arg USER=$USER -t ros_dev_env .

