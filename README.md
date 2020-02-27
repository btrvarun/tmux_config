# Configurations for linux
My tmux, vim, i3 and alacritty configuration

### Screenshot

![Configuration Screenshot](/images/screenshot.png?raw=true "Configuration screenshot")

### Installation

Start by cloning this repo to your linux machine, installing tmux and vim

The vim configuration is from https://github.com/kepbod/ivim/ with a few minor
tweaks from my side

```bash
git clone --recurse-submodule https://github.com/btrvarun/tmux_config.git ~/.tmux/
ln -s ~/.tmux/.tmux.conf ~/.tmux.conf
ln -s ~/.tmux/.vimrc ~/.vimrc

# debian:
sudo apt install tmux vim

#arch-linux:
sudo pacman -S tmux vim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
```

now activate the default bashrc script
```
exec bash
```

Tmux is open, Install the plugins by pressing: 
```
Ctrl+a I (capital i)
```

Now link your alacritty configuration after installing alacritty:
```bash
sudo pacman -S alacritty
rm ~/.config/alacritty/alacritty.yaml	
ls -s ~/.tmux/alacritty.yaml ~/.config/alacritty/alacritty.yaml
```

Your configuration is ready to go!
