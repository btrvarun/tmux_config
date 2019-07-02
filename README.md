# Tmux config
My tmux configuration

### Installation

Start by cloning this repo to your linux machine and installing tmux

```bash
git clone --recurse-submodule https://github.com/btrvarun/tmux_config.git ~/.tmux/
ln -s ~/.tmux/.tmux.conf ~/.tmux.conf

# debian:
sudo apt install tmux powerline fonts-powerline

#arch-linux:
sudo pacman -S tmux powerline powerline-fonts
```

### Configuration


now add the following lines into your ~/.bashrc file
```
# TMUX scripting
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# To activate virtual environment if present
if [[ -d "venv" ]]; then
	source venv/bin/activate
fi

# powerline
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh

```

now activate the default bashrc script
```
exec bash
```

Tmux is open, Install the plugins by pressing: 

Ctrl+a I (capital i)

Your tmux is ready to go! Now follow my vim configuration instructions!
