# Ansible bootstrap

Reproduces this setup on a fresh Fedora install.

## Run

```sh
sudo dnf install -y ansible stow
ansible-playbook -K -i localhost, -c local ansible/playbook.yml
```

`-K` prompts for the sudo password (needed for dnf tasks).

## What it does

- Installs dnf packages (WM, CLI tools, dev runtimes, fonts, build deps).
- Installs nvm, then the current LTS node; npm globals go under that node version.
- Installs cargo tools (stylua).
- Clones + builds source-only apps under `~/Packages/` — ghostty (zig),
  neovim (master), lazydocker (go install).

## Caveats on source builds

- **ghostty** needs a zig version compatible with main. If Fedora's `zig` package
  lags, fetch the right release from ziglang.org manually.
- **neovim** tracks master — expect occasional breakage. Pin `version:` in the
  task to a tag if you want stability.
- Runs `stow` for every dotfile package in this repo.
- Sets zsh as the default shell.

## Adding packages

Edit `playbook.yml` vars:

- `dnf_packages` — system packages.
- `npm_globals` — user-level node tools.
- `cargo_tools` — user-level rust tools.
- `stow_packages` — dotfile dirs to symlink.

## Not handled

- `1pass`, `demergi` — personal binaries, install manually.
- Neovim plugin managers / mason — handled by nvim on first launch.
- COPR repos — add with `community.general.copr` if ever needed
  (e.g. for `rofi-wayland`).
