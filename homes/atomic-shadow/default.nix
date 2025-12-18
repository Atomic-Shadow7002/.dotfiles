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
    pkgs.bibata-cursors
    # programs
    pkgs.codebook
    pkgs.deno
    pkgs.distrobox
    (pkgs.bottles.override {
      removeWarningPopup = true;
    })
    pkgs.gnumake
    pkgs.blender
    pkgs.scrcpy
    pkgs.flutter332
    pkgs.android-studio
    pkgs.gradle
    pkgs.brave
    pkgs.vscode
    pkgs.telegram-desktop
    pkgs.vlc
    pkgs.firefox
    pkgs.nodejs
    pkgs.nodePackages."@angular/cli"
    pkgs.gcc
    pkgs.openjdk
    pkgs.lsof
    pkgs.fd
    pkgs.ffmpeg
    pkgs.ferium
    pkgs.fish-lsp
    pkgs.inotify-tools
    pkgs.jq
    pkgs.just
    pkgs.krita
    pkgs.kdePackages.kconfig
    pkgs.kdePackages.karousel
    pkgs.kdePackages.kde-gtk-config
    pkgs.lazyjj
    pkgs.legcord
    pkgs.libreoffice-qt-fresh
    pkgs.mpv
    pkgs.markdown-oxide
    pkgs.nvd
    pkgs.nixd
    pkgs.nix-alien
    pkgs.nix-search-tv
    pkgs.nixfmt-rfc-style
    pkgs.nix-output-monitor
    pkgs.podman-compose
    (pkgs.prismlauncher.override {
      jdks = [ pkgs.jdk21 ];
    })
    pkgs.quickemu
    pkgs.ripgrep
    pkgs.ripgrep-all
    pkgs.simple-completion-language-server
    pkgs.taplo
    pkgs.typst
    pkgs.tinymist
    pkgs.typstyle
    pkgs.unrar
    pkgs.vscode-langservers-extracted
    pkgs.wl-clipboard
    pkgs.youtube-music
    pkgs.yaml-language-server
    pkgs.zathura
    pkgs.zed-editor-fhs
    pkgs.ngrok
    pkgs.sunshine
    # fonts
    pkgs.maple-mono.NF
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
  # Catppuccin!
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

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
    ./librewolf.nix
    ./obs-studio.nix
    ./starship.nix
    ./yazi.nix
    ./zellij.nix
    ./zoxide.nix
    ./cursor.nix
  ];

}
