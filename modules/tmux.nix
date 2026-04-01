{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    prefix = "C-s";
    escapeTime = 50;
    baseIndex = 1;
    terminal = "xterm-256color";
    sensibleOnTop = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '30'
        '';
      }
      yank
    ];

    extraConfig = ''
      # Yazi image preview
      set -g allow-passthrough on

      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      set-option -ga terminal-overrides ",xterm-256color:RGB"

      set-option -g set-titles on
      set-option -g set-titles-string "#S / #W"

      bind-key x kill-pane
      bind-key + split-window -l 20%

      set -g detach-on-destroy off

      bind-key -r t run-shell "tmux neww tmux-sessionizer"
      bind-key -r n run-shell "tmux-sessionizer ~/.config/nvim"
      bind-key -r b run-shell "tmux-sessionizer Home"
      bind-key -r , run-shell "tmux-sessionizer ~/Notes"

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      bind s choose-tree -sZ -O name

      set -g status-right 'Continuum status: #{continuum_status}'
      setw -g pane-base-index 1

      set -g status-position top

      # Theme
      set-option -g status-style bg=default,fg=default
      set-option -g status-justify centre
      set-option -g status-left '#[bg=default,fg=default,bold]#{?client_prefix,,  tmux  }#[bg=#{@minimal-tmux-bg},fg=black,bold]#{?client_prefix,  tmux  ,}'
      set-option -g status-right '#S'
      set-option -g window-status-format ' #I. #S:#W '
      set-option -g window-status-current-format '#[bg=#{@minimal-tmux-bg},fg=#000000] #S:#W#{?window_zoomed_flag, 󰊓 , }'
      set -g pane-border-style "bg=#1a1b26 fg=#1a1b26"
      set -g pane-active-border-style "bg=#1a1b26 fg=#3d59a1"
    '';
  };
}
