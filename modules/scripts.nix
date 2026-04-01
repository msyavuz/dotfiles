{ config, pkgs, ... }:

{
  # Custom scripts → ~/.local/bin/scripts/
  home.file = {
    ".local/bin/scripts/tmux-sessionizer" = {
      source = ../scripts/tmux-sessionizer;
      executable = true;
    };
    ".local/bin/scripts/docker-bar.sh" = {
      source = ../scripts/docker-bar.sh;
      executable = true;
    };
    ".local/bin/scripts/create-pr-note.sh" = {
      source = ../scripts/create-pr-note.sh;
      executable = true;
    };
    ".local/bin/scripts/csvi-open" = {
      source = ../scripts/csvi-open;
      executable = true;
    };
    ".local/bin/scripts/github_pr_notifier.py" = {
      source = ../scripts/github_pr_notifier.py;
      executable = true;
    };
  };

  # Default config files
  xdg.configFile = {
    "defaults/.clang-format".text = ''
      ---
      BasedOnStyle: LLVM
      IndentWidth: 4
      TabWidth: 4
      UseTab: Never
      ---
    '';
    "defaults/.commitlintrc.json".text = builtins.toJSON {
      extends = [ "@commitlint/config-conventional" ];
    };
    "defaults/.sql.json".text = builtins.toJSON {
      tabWidth = 4;
    };
  };

  # Wallpapers → ~/Pictures/
  home.file."Pictures/disco.png".source = ../wallpapers/disco.png;
  home.file."Pictures/revachol.jpg".source = ../wallpapers/revachol.jpg;
}
