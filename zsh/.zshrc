_does_exist() {
    if command -v $1 >/dev/null 2>&1; then
        return 0
    fi

    return 1
}

_source_if_exists() {
    if [[ -f "$1" ]]; then
        source "$1"
    fi
}

autoload -U colors && colors
setopt autocd
stty stop undef
setopt interactive_comments

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

export XDG_CONFIG_HOME=$HOME/.config
PERSONAL=$XDG_CONFIG_HOME/personal

for file in $(find -L "$PERSONAL" -type f); do
    source "$file"
done

bindkey -v
export KEYTIMEOUT=1

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

bindkey -s ^f "tmux-sessionizer\n"
bindkey -s ^o "_lfcd\n"
bindkey -s ^d "_dotfile_search\n"
bindkey -s ^a "zet search --fzf-options \"--preview='bat --color=always --style=numbers {}' --preview-window=bottom:80%\"\n"
bindkey -s ^s "zet search --folder College --fzf-options \"--preview='bat --color=always --style=numbers {}' --preview-window=bottom:80%\"\n"
bindkey -s ^n "_new\n"

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

_does_exist zoxide && eval "$(zoxide init zsh)"
_does_exist fzf && eval "$(fzf --zsh)"
_does_exist zet && eval "$(zet completion zsh)"
_does_exist pomo && eval "$(pomo completion zsh)"
_does_exist aircon && eval "$(aircon completion zsh)"

_source_if_exists $HOME/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
_source_if_exists $HOME/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh
_source_if_exists $HOME/.tokens
