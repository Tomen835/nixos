# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/tom/.zshrc'

autoload -Uz compinit
zstyle ':completion:*' menu yes select
zmodload zsh/complist
compinit
# End of lines added by compinstall
#
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search



autoload -Uz colors && colors

source "$ZDOTDIR/zsh-functions"

zsh_add_file "zsh-prompt"

zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"


bindkey -s '^r' 'ranger\n'
#
alias mainframe='cmatrix -B -C blue'
#aliases for flatpaks
alias night='sh ~/night.sh'
alias day='sh ~/day.sh'
 #creates aliases to back up and restore configs
alias backup='sh ~/backups/backup.sh'
alias restore='sh ~/backups/restore.sh'
# hacked switch boot
alias switch='nix-shell -p python3Minimal python311Packages.pyusb; python3 ~/fusee-launcher/fusee-launcher.py ~/hekate/hekate_ctcaer_6.0.3.bin'

export EDITOR=vim
# Added by zap installation script
PATH=$PATH:$HOME/.local/bin/
# Added by zap installation script
PATH=$PATH:$HOME/.local/bin/


alias update='cp ~/nixos/configuration.nix ~/nixos/configuration-backup.nix; cp /etc/nixos/configuration.nix ~/nixos/configuration.nix; sudo nixos-rebuild switch'

# alias protonvpnc='sudo tailscale down; protonvpn-cli c'
# alias protonvpnd='protonvpn-cli d; sudo tailscale up'
