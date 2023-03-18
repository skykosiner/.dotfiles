cowsay "GAY" | lolcat
setopt autocd		# Automatically cd into typed directory.
autoload -U colors && colors	# Load colors

# ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="robbyrussell"
# eval "$(starship init zsh)"
export XDG_CONFIG_HOME=$HOME/.config
PERSONAL=$XDG_CONFIG_HOME/personal

for i in `find -L $PERSONAL`; do
    source $i
done

# megaMind

# MacOS stuff
alias urlS="/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -dump URLSchemeBinding"

alias iCloud="cd /Users/yonikosiner/Library/Mobile\ Documents/com~apple~CloudDocs"

# Normall stuff and Linux
autoload -U colors && colors

#[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1

export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json

autoload -Uz vcs_info
# zstyle ':vcs_info:*' enable git svn
# zstyle ':vcs_info:git*' formats " %%B%{$fg[yellow]λ %%B%{$fg[green]%b"
#
# precmd() {
#     vcs_info
# }
#
# PS1='%B$fg[magenta]%~%]${vcs_info_msg_0_}'$'\n'"$fg[green]$ %b"
# PROMPT='%B%F{219}[%f%b%B%F{219}%n%f%b %B$(pwd_t)%B%F{219}]%(!.#.$)%f%b '

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

# Edit line in $EDITOR with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

# Prompt stollen from luke smith
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

source ~/bookMarks

HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000
setopt appendhistory

eval "$(zoxide init zsh)"
