autoload -U colors && colors
# cowsay "GAY" | lolcat
# pfetch
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
# bindkey -s ^n "cd ~/Documents/Linux-btw/ && vim .\n"

autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
setopt appendhistory
compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

source $HOME/.config/personal/bookMarks
source $HOME/.config/personal/bookMarkFiles
source $HOME/.todoist_token

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
