apt install -y curl stow tmux alacritty vim-gtk3 gnome-tweaks git xclip vlc \
            ninja-build gettext cmake curl build-essential \
            ffmpeg 7zip jq poppler-utils fd-find ripgrep zoxide imagemagick \
            fonts-noto-core fonts-noto-ui-core \

# to stop breaking fonts in browser
rm -f /usr/share/fonts/truetype/freefont/FreeSans*
rm -f /usr/share/fonts/truetype/freefont/FreeSerif*
fc-cache -f -v

# install latest stable rust toolchain
#
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update 

# install neovim
#
(mkdir temp_nvim \
&& cd temp_nvim \
&& git clone https://github.com/neovim/neovim \
&& cd neovim \
&& make CMAKE_BUILD_TYPE=Release \
&& make install)
rm -rf temp_nvim

#install fzf
#
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --completion --no-key-bindings --no-update-rc --no-zsh --no-fish

# install yazi
#
cargo install --force yazi-build

# install ghostty
#
curl -fsSL https://download.opensuse.org/repositories/home:clayrisser:sid/Debian_Unstable/Release.key | gpg --dearmor | sudo tee /etc/apt/keyrings/home_clayrisser_sid.gpg > /dev/null
ARCH="$(dpkg --print-architecture)"
sudo tee /etc/apt/sources.list.d/home:clayrisser:sid.sources > /dev/null <<EOF
Types: deb
URIs: http://download.opensuse.org/repositories/home:/clayrisser:/sid/Debian_Unstable/
Suites: /
Architectures: $ARCH
Signed-By: /etc/apt/keyrings/home_clayrisser_sid.gpg
EOF
apt update
apt install ghostty

# make alacritty the default terminal
#
update-alternatives --install  /usr/bin/x-terminal-emulator x-terminal-emulator $(which alacritty) 50
update-alternatives --set x-terminal-emulator $(which alacritty)


