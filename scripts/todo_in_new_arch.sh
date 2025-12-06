# install basic packages
sudo pacman -S --noconfirm man-db
sudo pacman -S --needed --noconfirm base-devel \
	clang \
	curl \
	fzf \
	gcc \
	git \
    ghostty \
	neovim \
	noto-fonts \
	ripgrep \
	stow \
	wget \
	unzip \
    wl-clipboard \
	xcb-util-cursor \
    yazi \
	zoxide 

# fix font-issue in browser
# fc-cache -f -v

# get dotfiles
# (git clone https://github.com/attheratefayez/dotfiles.git \
# && rm ~/.bashrc && rm ~/.config/niri/config.kdl \
# && cd ./dotfiles && stow .
# )

# install uv
curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env

# creating colors for waybar
(cd ~/Public/ && mkdir test && cd test && uv add pywal && uv run python3 -m pywal --theme base16-material && cd .. && rm -rf test)


## install rust
#curl https://sh.rustup.rs -sSf | sh -s -- -y
#source $HOME/.cargo/env 
#
## install xwayland-satellite
#(cd ~/Public/ && \
#git clone https://github.com/Supreeeme/xwayland-satellite.git && \
#cd xwayland-satellite && \
#cargo build --release && \
#cd .. && rm -rf xwayland-satellite)
#
## install nerd-font
#(mkdir -p /home/$USER/.local/share/fonts \
#&& cd /home/$USER/.local/share/fonts \
#&& wget -O firacode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip \
#&& unzip firacode.zip -d firacode && mv ./firacode/*-Regular.ttf ./ && rm -rf firacode.zip firacode)

# install brave-browser
#curl -fsS https://dl.brave.com/install.sh | sh











#
#sudo apt install -y curl stow tmux alacritty vim-gtk3 gnome-tweaks git xclip vlc \
#            ninja-build gettext cmake curl build-essential clang-format \
#            ffmpeg 7zip jq poppler-utils fd-find ripgrep zoxide imagemagick \
#            fonts-noto-core fonts-noto-ui-core \
#
## to stop breaking fonts in browser
#rm -f /usr/share/fonts/truetype/freefont/FreeSans*
#rm -f /usr/share/fonts/truetype/freefont/FreeSerif*
#fc-cache -f -v
#
## install latest stable rust toolchain
##
##curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
#. "$HOME/.cargo/env"
#rustup update 
#
## install neovim
##
#(mkdir temp_nvim \
#&& cd temp_nvim \
#&& git clone https://github.com/neovim/neovim \
#&& cd neovim \
#&& make CMAKE_BUILD_TYPE=Release \
#&& sudo make install)
#rm -rf temp_nvim
#
##install fzf
##
#git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
#~/.fzf/install --completion --no-key-bindings --no-update-rc --no-zsh --no-fish
#
## install yazi
##
#cargo install --force yazi-build
#
## install ghostty
##
#curl -fsSL https://download.opensuse.org/repositories/home:clayrisser:sid/Debian_Unstable/Release.key | gpg --dearmor | sudo tee /etc/apt/keyrings/home_clayrisser_sid.gpg > /dev/null
#ARCH="$(dpkg --print-architecture)"
#sudo tee /etc/apt/sources.list.d/home:clayrisser:sid.sources > /dev/null <<EOF
#Types: deb
#URIs: http://download.opensuse.org/repositories/home:/clayrisser:/sid/Debian_Unstable/
#Suites: /
#Architectures: $ARCH
#Signed-By: /etc/apt/keyrings/home_clayrisser_sid.gpg
#EOF
#sudo apt update
#sudo apt install ghostty
#
## make alacritty the default terminal
##
#sudo update-alternatives --install  /usr/bin/x-terminal-emulator x-terminal-emulator $(which alacritty) 50
#sudo update-alternatives --set x-terminal-emulator $(which alacritty)
#
##install uv
## On macOS and Linux.
#curl -LsSf https://astral.sh/uv/install.sh | sh
#
## creating colors for waybar
#(cd ~/Public/ && mkdir test && cd test && uv add pywal && uv run python3 -m pywal --theme base16-material && cd .. && rm -rf test && cd)
#
## install nvidia-container toolkit
##
#curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | \
#gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
#&& curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
#sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
#sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
#
#sudo apt update
#
#export NVIDIA_CONTAINER_TOOLKIT_VERSION=1.18.0-1 \
#&& sudo apt install -y \
#      nvidia-container-toolkit=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
#      nvidia-container-toolkit-base=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
#      libnvidia-container-tools=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
#      libnvidia-container1=${NVIDIA_CONTAINER_TOOLKIT_VERSION}
#
#sudo nvidia-ctk runtime configure --runtime=docker && sudo systemctl restart docker
## add local:docker in xhost. commnad: xhost +local:docker, so that 
## docker containers can use xhost to open windows
