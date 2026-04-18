{ pkgs, config, ... }:

let inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  home.packages = with pkgs; [ tmux ];
  xdg.configFile."tmux/.tmux-chat-command".source =
    mkOutOfStoreSymlink "../../../../tmux/.tmux-chat-command";
  xdg.configFile."tmux/.tux-cht-languages".source =
    mkOutOfStoreSymlink "../../../../tmux/.tmux-cht-languages";

  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    prefix = "C-a";
    shortcut = "a";
    keyMode = "vi";
    mouse = true;
    extraConfig = ''
      # set -g default-terminal "tmux-256color"
      set -g default-terminal "xterm-256color"
      # set -ga terminal-overrides ",xterm-256color:Tc"

      set -g pane-border-style "fg=#171717"
      set -g pane-active-border-style "fg=#171717"

      set-option -g status-interval 1
      set -g status-right "#(pomo) #(toggl-cli status)"
      set-option -g status-right-length 100

      set -g status-position top
      set -g status-style "fg=#665c54"

      bind C-f display-popup -E "~/.local/bin/tmux-sessionizer"
      bind g display-popup -w 100 -h 30 -E "lazygit"

      bind C-c display-popup -w 101 -h 30 "$SHELL -c 'tte -i ~/personal/kirk-ascii/test.txt --frame-rate 900 --canvas-width 0 --canvas-height 0 --reuse-canvas --anchor-canvas c --anchor-text c --existing-color-handling always print; read'"

      bind r source-file ~/.config/tmux/tmux.conf
      set -g base-index 1

      set-window-option -g mode-keys vi
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'wl-copy'

      # vi keys to resize
      bind -r C-k resize-pane -U 1
      bind -r C-j resize-pane -D 1
      bind -r C-h resize-pane -L 1
      bind -r C-l resize-pane -R 1

      # vim-like pane switching
      bind -r ^ last-window
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R

      bind -r - split-window -h
      bind -r _ split-window -v

      bind-key -r i run-shell "tmux neww ~/.local/bin/tmux-cht"

      bind-key -r H run-shell "~/.local/bin/tmux-sessionizer ~/Documents/Linux-btw/"
      bind-key -r T run-shell "~/.local/bin/tmux-sessionizer ~/.dotfiles/"
      bind-key -r U run-shell "~/.local/bin/tmux-sessionizer ~/work/dish-diaries/"

      # Use tmux to switch an open session
      bind -r C-s \
      split-window -l 10 'session=$(tmux list-sessions -F "#{session_name}" | fzf --query="$1" --select-1 --exit-0) && tmux switch-client -t "$session"' \;
    '';
  };
}
