{
  programs.ghostty = {
    enable = true;
    settings = {
      window-decoration = false;
      confirm-close-surface = false;
      theme = "tokyonight";
      background-opacity = 0.9;
      mouse-hide-while-typing = true;
      font-size = 13;
      window-padding-y = 8;
      window-padding-x = 4;
      gtk-single-instance = true;
      bell-features = "audio,system";
    };
  };
}
