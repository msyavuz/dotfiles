{ pkgs, ... }:

{
  # Btop
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "tokyonight";
      theme_background = false;
      vim_keys = true;
    };
    themes = {
      tokyonight = ''
        # Theme: tokyonight_night
        # By: Folke Lemaitre

        theme[main_bg]="#1a1b26"
        theme[main_fg]="#c0caf5"

        theme[title]="#c0caf5"
        theme[hi_fg]="#ff9e64"
        theme[selected_bg]="#292e42"
        theme[selected_fg]="#7dcfff"
        theme[proc_misc]="#7dcfff"
        theme[cpu_box]="#27a1b9"
        theme[mem_box]="#27a1b9"
        theme[net_box]="#27a1b9"
        theme[proc_box]="#27a1b9"
        theme[div_line]="#27a1b9"

        theme[temp_start]="#9ece6a"
        theme[temp_mid]="#e0af68"
        theme[temp_end]="#f7768e"

        theme[cpu_start]="#9ece6a"
        theme[cpu_mid]="#e0af68"
        theme[cpu_end]="#f7768e"

        theme[free_start]="#9ece6a"
        theme[free_mid]="#e0af68"
        theme[free_end]="#f7768e"

        theme[cached_start]="#9ece6a"
        theme[cached_mid]="#e0af68"
        theme[cached_end]="#f7768e"

        theme[available_start]="#9ece6a"
        theme[available_mid]="#e0af68"
        theme[available_end]="#f7768e"

        theme[used_start]="#9ece6a"
        theme[used_mid]="#e0af68"
        theme[used_end]="#f7768e"

        theme[download_start]="#9ece6a"
        theme[download_mid]="#e0af68"
        theme[download_end]="#f7768e"

        theme[upload_start]="#9ece6a"
        theme[upload_mid]="#e0af68"
        theme[upload_end]="#f7768e"
      '';
    };
  };

  # Zathura PDF viewer
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";

      # Tokyonight color theme
      notification-error-bg = "#f7768e";
      notification-error-fg = "#c0caf5";
      notification-warning-bg = "#e0af68";
      notification-warning-fg = "#414868";
      notification-bg = "#1a1b26";
      notification-fg = "#c0caf5";
      completion-bg = "#1a1b26";
      completion-fg = "#a9b1d6";
      completion-group-bg = "#1a1b26";
      completion-group-fg = "#a9b1d6";
      completion-highlight-bg = "#414868";
      completion-highlight-fg = "#c0caf5";
      index-bg = "#1a1b26";
      index-fg = "#c0caf5";
      index-active-bg = "#414868";
      index-active-fg = "#c0caf5";
      inputbar-bg = "#1a1b26";
      inputbar-fg = "#c0caf5";
      statusbar-bg = "#1a1b26";
      statusbar-fg = "#c0caf5";
      highlight-color = "#e0af68";
      highlight-active-color = "#9ece6a";
      default-bg = "#1a1b26";
      default-fg = "#c0caf5";
      render-loading = true;
      render-loading-fg = "#1a1b26";
      render-loading-bg = "#c0caf5";
      recolor-lightcolor = "#1a1b26";
      recolor-darkcolor = "#c0caf5";
      recolor = true;
    };
  };
}
