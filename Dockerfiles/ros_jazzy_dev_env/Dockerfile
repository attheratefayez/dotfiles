FROM osrf/ros:jazzy-desktop-full


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
#     && mkdir /home/$USER/.config && chown $USER:$UID /home/$USER/.config \
RUN echo $USER ALL=\(ALL\) NOPASSWD: ALL > /etc/sudoers.d/$USER \
    && chmod 0440 /etc/sudoers.d/$USER

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


# docker run -it --name dev_microros_jazzy --net=host --user ubuntu \
#  --volume /tmp/.X11-unix:/tmp/.X11-unix --env=DISPLAY \
#  --volume /usr/share/fonts:/usr/share/fonts --volume /home/fayez/Bugs/Rosjects:/home/ubuntu/Bugs/Rosjects:rw \
#  --volume /dev:/dev --privileged --runtime nvidia --gpus all ros_jazzy_dev_env
#

# docker run -it --name dev_kernelbot --hostname dev_kernelbot.uatech \
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
# --runtime nvidia --gpus all ros_dev_env
