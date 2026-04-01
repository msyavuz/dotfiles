{ config, pkgs, ... }:

{
  home.username = "msyavuz";
  home.homeDirectory = "/home/msyavuz";
  home.stateVersion = "25.05";

  imports = [
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/terminal.nix
    ./modules/tmux.nix
    ./modules/i3.nix
    ./modules/appearance.nix
    ./modules/services.nix
    ./modules/tools.nix
    ./modules/scripts.nix
  ];

  home.packages = with pkgs; [
    # CLI tools
    eza
    lazygit
    lazydocker
    feh
    flameshot
    brightnessctl
    xclip

    # Dev tools
    jq
    curl
    usql

    # Fonts
    noto-fonts
    dejavu_fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "$HOME/Applications/zen_browser.appimage";
    T_SESSION_NAME_INCLUDE_PARENT = "false";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    GTK_USE_PORTAL = "0";
    OLLAMA_MODELS = "$HOME/.ollama-models";
    SUPERSET_CONFIG_PATH = "$HOME/Work/superset0/superset_config.py";
    ANDROID_HOME = "$HOME/Android/Sdk";
    DIRENV_CACHE_DIR = "$HOME/.cache/direnv";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.local/bin/scripts"
    "$HOME/.cargo/bin"
    "$HOME/go/bin"
    "$HOME/.mix/escripts"
    "$HOME/scripts"
    "$HOME/.npm-packages/bin"
    "$HOME/.dotnet/tools"
    "$HOME/.opencode/bin"
    "$ANDROID_HOME/emulator"
    "$ANDROID_HOME/platform-tools"
  ];

  programs.home-manager.enable = true;
}
