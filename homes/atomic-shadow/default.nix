{ pkgs, ... }:

{
  # General home stuff.
  home.username = "atomic-shadow";
  home.homeDirectory = "/home/atomic-shadow";
  home.stateVersion = "25.05"; # DO NOT CHANGE!
  home.packages = [
    # themes and icons
    (pkgs.catppuccin-kde.override {
      flavour = [ "mocha" ];
      accents = [ "mauve" ];
      winDecStyles = [ "classic" ];
    })
    pkgs.android-studio
    pkgs.ani-cli
    pkgs.antigravity
    pkgs.bibata-cursors
    pkgs.blender
    (pkgs.bottles.override {
      removeWarningPopup = true;
    })
    pkgs.brave
    pkgs.codebook
    pkgs.dbeaver-bin
    pkgs.deno
    pkgs.distrobox
    pkgs.fd
    pkgs.ferium
    pkgs.ffmpeg
    pkgs.firefox
    pkgs.fish-lsp
    pkgs.gcc
    pkgs.gnumake
    pkgs.gradle
    pkgs.gtk3
    pkgs.inotify-tools
    pkgs.jq
    pkgs.just
    pkgs.kdePackages.karousel
    pkgs.kdePackages.kconfig
    pkgs.kdePackages.kde-gtk-config
    pkgs.krita
    pkgs.lazyjj
    pkgs.legcord
    pkgs.libreoffice-qt-fresh
    pkgs.lsof
    pkgs.maple-mono.NF
    pkgs.markdown-oxide
    pkgs.matugen
    pkgs.maven
    pkgs.mpv
    pkgs.ngrok
    pkgs.nix-alien
    pkgs.nix-output-monitor
    pkgs.nix-search-tv
    pkgs.nixd
    pkgs.nixfmt
    pkgs.noto-fonts-cjk-sans
    pkgs.nvd
    pkgs.openjdk21
    pkgs.pear-desktop
    pkgs.podman-compose
    pkgs.postman
    (pkgs.prismlauncher.override {
      jdks = [ pkgs.jdk21 ];
    })
    pkgs.quickemu
    pkgs.ripgrep
    pkgs.ripgrep-all
    pkgs.scrcpy
    pkgs.simple-completion-language-server
    pkgs.sunshine
    pkgs.taplo
    pkgs.telegram-desktop
    pkgs.tinymist
    pkgs.tree
    pkgs.typst
    pkgs.typstyle
    pkgs.unrar
    pkgs.vesktop
    pkgs.vlc
    pkgs.vscode
    pkgs.vscode-langservers-extracted
    pkgs.wl-clipboard
    pkgs.wl-mirror
    pkgs.yaml-language-server
    pkgs.zathura
    pkgs.zed-editor-fhs
  ];

  # Fontconfig stuff.
  fonts.fontconfig.enable = true;

  # Let home-manager update itself.
  programs.home-manager.enable = true;

  # Allow unfree.
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  # Modules.
  imports = [
    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./fish.nix
    ./flatpak.nix
    ./ghostty.nix
    ./git.nix
    ./gpg.nix
    ./helix.nix
    ./jujutsu.nix
    ./kdeconnect.nix
    ./obs-studio.nix
    ./starship.nix
    ./yazi.nix
    ./zellij.nix
    ./zoxide.nix
    ./niri.nix
    ./matugen.nix
    ./gtk.nix
  ];
}
