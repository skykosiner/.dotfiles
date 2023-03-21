cowsay "GAY" | lolcat
setopt autocd
autoload -U colors && colors

export XDG_CONFIG_HOME=$HOME/.config
PERSONAL=$XDG_CONFIG_HOME/personal

for i in `find -L $PERSONAL`; do
    source $i
done

alias urlS="/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -dump URLSchemeBinding"

alias iCloud="cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs"

export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json

bindkey -v
export KEYTIMEOUT=1

lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

bindkey -s ^f "tmux-sessionizer\n"
bindkey -s ^o "lfcd\n"

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

source ~/bookMarks

HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000
setopt appendhistory

eval "$(zoxide init zsh)"
