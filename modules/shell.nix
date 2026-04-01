{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;

    history = {
      size = 5000;
      save = 5000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      share = true;
      append = true;
    };

    shellAliases = {
      vi = "nvim";
      vim = "nvim";
      cd = "z";
      ls = "eza --icons=always";
      lg = "lazygit";
      lzd = "lazydocker";
      dnfin = "sudo dnf install";
      dnfre = "sudo dnf remove";
      ta = "tmux_attach";
      tk = "tmux kill-server";
      shad = "pnpm dlx shadcn@latest";
      time = "/usr/bin/time -f '%E real,%U user,%S sys'";
      sysen = "sudo systemctl enable";
      sysdis = "sudo systemctl disable";
      sysstart = "sudo systemctl start";
      sysstop = "sudo systemctl stop";
      dcup = "docker compose up";
      dcdown = "docker compose down";
      zen = "~/Applications/zen_browser.appimage";
      copy = "xclip -selection clipboard";
      tj = "tjournal";
      superset_backend = "superset db upgrade;superset fab create-admin;superset init;superset load-examples";
      superset_cyp = "superset db upgrade;superset load_test_users;superset load-examples --load-test-data;superset init;superset fab create-admin";
      remove_node_modules = "find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +";
      sql = "usql";
      list-wifi = "nmcli dev wifi list";
      mailhog = "MailHog";
      gru = "gruyere";
      conu = "nmcli connection up";
      cpn = "create-pr-note.sh";
      icat = "kitten icat";
      pcchanged = "pre-commit run --files $(git diff-tree --no-commit-id --name-only -r HEAD)";
      pcpr = "pre-commit run --from-ref origin/master --to-ref HEAD";
      superset-extensions = "/home/msyavuz/Work/superset/.venv/bin/superset-extensions";
    };

    plugins = [
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
      {
        name = "fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
      {
        name = "zsh-vi-mode";
        src = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode";
      }
    ];

    completionInit = "autoload -Uz compinit && compinit";

    initContent = ''
      # NVM
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

      # tmux attach helper
      function tmux_attach() {
        if [[ -n $(pgrep tmux) ]]; then
          tmux attach-session
        else
          tmux
        fi
      }

      # npm packages
      NPM_PACKAGES="''${HOME}/.npm-packages"
      export MANPATH="''${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

      # Angular CLI autocompletion
      source <(ng completion script) 2>/dev/null

      # fzf-tab styles
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza -1 --icons=always --color=always $realpath'
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
      zstyle ':fzf-tab:*' popup-min-size 100 8

      # pnpm
      export PNPM_HOME="/home/msyavuz/.local/share/pnpm"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac

      # linuxbrew
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" 2>/dev/null

      # bun
      [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
      export BUN_INSTALL="$HOME/.bun"
      export PATH="$BUN_INSTALL/bin:$PATH"

      export NODE_PATH=$NODE_PATH:`npm root -g`

      # luaver
      [ -s ~/.luaver/luaver ] && . ~/.luaver/luaver

      # NVM auto-load .nvmrc
      autoload -U add-zsh-hook
      load-nvmrc() {
        local node_version="$(nvm version)"
        local nvmrc_path="$(nvm_find_nvmrc)"
        if [ -n "$nvmrc_path" ]; then
          local nvmrc_node_version=$(nvm version "$(cat "''${nvmrc_path}")")
          if [ "$nvmrc_node_version" = "N/A" ]; then
            nvm install
          elif [ "$nvmrc_node_version" != "$node_version" ]; then
            nvm use
          fi
        elif [ "$node_version" != "$(nvm version default)" ]; then
          echo "Reverting to nvm default version"
          nvm use default
        fi
      }
      add-zsh-hook chpwd load-nvmrc
      load-nvmrc

      export ANDROID_STUDIO_PATH="/home/msyavuz/.local/share/JetBrains/Toolbox/apps/android-studio"
      export JAVA_HOME=/home/msyavuz/.gradle/jdks/eclipse_adoptium-17-amd64-linux.2
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      palette = "tokyonight";
      command_timeout = 1000;

      palettes.tokyonight = {
        blue = "#7aa2f7";
        bright-blue = "#7dcfff";
      };

      aws.symbol = "  ";
      buf.symbol = " ";
      c.symbol = " ";
      conda.symbol = " ";
      dart.symbol = " ";
      directory.read_only = " 󰌾";
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      fossil_branch.symbol = " ";
      git_branch.symbol = " ";
      golang.symbol = " ";
      guix_shell.symbol = " ";
      haskell.symbol = " ";
      haxe.symbol = " ";
      hg_branch.symbol = " ";
      hostname.ssh_symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      lua.symbol = " ";
      memory_usage.symbol = "󰍛 ";
      meson.symbol = "󰔷 ";
      nim.symbol = "󰆥 ";
      nix_shell.symbol = " ";
      nodejs.symbol = " ";
      package.symbol = "󰏗 ";
      pijul_channel.symbol = " ";
      python.symbol = " ";
      rlang.symbol = "󰟔 ";
      ruby.symbol = " ";
      rust.symbol = " ";
      scala.symbol = " ";

      os.symbols = {
        Alpaquita = " ";
        Alpine = " ";
        Amazon = " ";
        Android = " ";
        Arch = " ";
        Artix = " ";
        CentOS = " ";
        Debian = " ";
        DragonFly = " ";
        Emscripten = " ";
        EndeavourOS = " ";
        Fedora = " ";
        FreeBSD = " ";
        Garuda = "󰛓 ";
        Gentoo = " ";
        HardenedBSD = "󰞌 ";
        Illumos = "󰈸 ";
        Linux = " ";
        Mabox = " ";
        Macos = " ";
        Manjaro = " ";
        Mariner = " ";
        MidnightBSD = " ";
        Mint = " ";
        NetBSD = " ";
        NixOS = " ";
        OpenBSD = "󰈺 ";
        openSUSE = " ";
        OracleLinux = "󰌷 ";
        Pop = " ";
        Raspbian = " ";
        Redhat = " ";
        RedHatEnterprise = " ";
        Redox = "󰀘 ";
        Solus = "󰠳 ";
        SUSE = " ";
        Ubuntu = " ";
        Unknown = " ";
        Windows = "󰍲 ";
      };
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    stdlib = ''
      layout_uv() {
          if [[ -d ".venv" ]]; then
              VIRTUAL_ENV="$(pwd)/.venv"
          fi

          if [[ -z $VIRTUAL_ENV || ! -d $VIRTUAL_ENV ]]; then
              log_status "No virtual environment exists. Executing \`uv venv\` to create one."
              uv venv
              VIRTUAL_ENV="$(pwd)/.venv"
          fi

          PATH_add "$VIRTUAL_ENV/bin"
          export UV_ACTIVE=1
          export VIRTUAL_ENV
      }
    '';
  };
}
