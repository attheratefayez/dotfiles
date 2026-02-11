# install basic packages
sudo pacman -S --noconfirm man-db

sudo pacman -S --needed --noconfirm base-devel \
	btop \
	clang \
	curl \
	docker docker-compose docker-buildx \
	firefox \
	fzf \
	gcc \
	git \
	ghostty \
	neovim \
	networkmanager \
	noto-fonts \
	os-prober \
	ripgrep \
	stow \
	tmux \
	wget \
	unzip \
	vlc \
	vlc-plugins-all \
	wl-clipboard \
	xcb-util-cursor \
	yazi \
	zoxide \
	7zip

# make docker run without sudo 
# seems like it comes configured for now
# sudo groupadd docker && sudo usermod -aG docker $USER && newgrp docker

# fix font-issue in browser
fc-cache -f -v

# get dotfiles
# (cd ~ && git clone https://github.com/attheratefayez/dotfiles.git \
# && rm ~/.bashrc && rm ~/.config/niri/config.kdl \
# && cd ./dotfiles && stow .
# )

# install uv
if ! command -v uv 2>&1 > /dev/null; then
	curl -LsSf https://astral.sh/uv/install.sh | sh
	source $HOME/.local/bin/env
else
	echo -e "\n\nUV is installed. Skipping.\n\n"
fi

## creating colors for waybar
#(cd ~/Public/ && mkdir test && cd test && uv init && uv add pywal && uv run python3 -m pywal --theme base16-material && cd .. && rm -rf test)

## install rust
if ! command -v cargo 2>&1 > /dev/null; then
	curl https://sh.rustup.rs -sSf | sh -s -- -y
	source $HOME/.cargo/env 
else
	echo -e "\n\nRust is installed. Skipping.\n\n"
fi

# install xwayland-satellite
if ! command -v xwayland-satellite 2>&1 > /dev/null; then
	(cd ~/Public/ && git clone https://github.com/Supreeeme/xwayland-satellite.git \
		&& cd xwayland-satellite && cargo build --release \
		&& sudo mv ./target/release/xwayland-satellite /usr/bin/ \
		&& cd .. && rm -rf xwayland-satellite)
else
	echo -e "\n\nxwayland-satellite is installed. Skipping.\n\n"
fi

# set prefer-dark option for applications
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#install paru
if ! command -v brave 2>&1 > /dev/null; then
	(cd ~/Public/ && git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si)
else 
	echo -e "\n\nParu installed. Skipping.\n\n"
fi


# install brave-browser
if ! command -v brave 2>&1 > /dev/null; then
	paru -S brave-bin
else 
	echo -e "\n\nBrave browser installed. Skipping.\n\n"
fi

# get nerd-fonts
paru -S ttf-firacode-nerd

# get noctalia-shell
if ! paru -Qk noctalia-shell 2>&1 > /dev/null; then
	paru -S --noconfirm noctalia-shell
else 
	echo -e "\n\nNoctalia-shell installed. Skipping.\n\n"
fi

# configure ssh
if [ -z "$(ls -A "/home/$USER/.ssh/id_rsa")" ]; then
    ssh-keygen -t rsa -b 4096 -C "faizurrahman.fayez@gmail.com"
    eval $(ssh-agent -s)
    ssh-add
else 
    echo -e "\n\nSSH already configured.\n\n"
fi

# configure network manager
sudo systemctl enable --now NetworkManager.service
nmcli device wifi connect "ABCD" --ask

