autoload -U colors && colors
setopt autocd
stty stop undef
setopt interactive_comments

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

export XDG_CONFIG_HOME=$HOME/.config
PERSONAL=$XDG_CONFIG_HOME/personal

for i in `find -L $PERSONAL`; do
    source $i
done

bindkey -v
export KEYTIMEOUT=1

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lfub -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

bindkey -s ^f "tmux-sessionizer\n"
bindkey -s ^o "lfcd\n"
bindkey -s ^d "de\n"
bindkey -s ^a "oe\n"

autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{green}%~%f %F{magenta}${vcs_info_msg_0_}%f$ '

HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
setopt appendhistory
compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION

eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
# eval "$(starship init zsh)"

hostname=$(hostnamectl | grep -i "static hostname" | awk '{print $3}')

# Check if it's a mac
if [[ $uname != "Darwin" ]]; then
    source $HOME/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source $HOME/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi;

source $HOME/.tokens
