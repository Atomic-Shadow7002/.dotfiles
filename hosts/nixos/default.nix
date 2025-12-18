{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/hosts/common-settings.nix
    ../../modules/hosts/trusted-substituters.nix
    ../../modules/hosts/security.nix
    ../../modules/hosts/netmod.nix
    ../../modules/hosts/bluetooth.nix
    ../../modules/hosts/pipewire.nix
    ../../modules/hosts/graphics.nix
    ../../modules/hosts/podman.nix
    ../../modules/hosts/vm.nix
    ../../modules/hosts/sunshine.nix
    ../../modules/hosts/android.nix
  ];

  # Some stuff that should exist independently.
  system.stateVersion = "25.05";
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  # Firmware stuff.
  services.fwupd.enable = true;

  # Fine-grained boot stuff.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModprobeConfig = "options kvm_intel nested=1";
  boot.kernelPackages = pkgs.linuxPackages_6_16;

  # Zram stuff.
  zramSwap.enable = true;

  # Fine-grained localization stuff.
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Miscellaneous stuff.
  common-settings.enable = true;
  common-settings.flake = "/home/atomic-shadow/.dotfiles";
  common-settings.gc.options = "--delete-older-than 7d";
  trusted-substituters.enable = true;
  security.enable = true;

  # Networking stuff.
  netmod.enable = true;
  netmod.name = "nixos";

  # Media stuff.
  bluetooth.enable = true;
  pipewire.enable = true;

  # Display Manager stuff.
  services.displayManager.ly.enable = true;

  # Graphics
  graphics.enable = true;

  # Virtualization stuff.
  podman.enable = true;
  vm.enable = true;
  vm.kvm.enable = true;
  # vm.waydroid.enable = true;
  virtualisation.vmware.host.enable = true;
  virtualisation.vmware.guest.enable = true;

  # Sunshine (and Moonlight) stuff.
  sunshine.enable = true;

  # Flatpak stuff.
  services.flatpak.enable = true;

  # AppImage stuff.
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.appimage.package = pkgs.appimage-run.override {
    extraPkgs = pkgs: [
      pkgs.libxcrypt
      pkgs.icu
    ];
  };

  # Nix-ld.
  programs.nix-ld.enable = true;

  # OpenSHH
  services.openssh.enable = true;

  # Android
  android.enable = true;

  # Printing + Scanning
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplipWithPlugin ];

  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];

  # Fonts
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.fira-code
      pkgs.nerd-fonts.caskaydia-cove
      pkgs.maple-mono.NF
    ];
  };

  # Me!
  users.users.atomic-shadow = {
    isNormalUser = true;
    description = "Atomic Shadow";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "bluetooth"
      "libvirtd"
      "kvm"
      "adbusers"
    ];
  };

  # Variables stuff.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ZED_WINDOW_DECORATIONS = "server";
    SIGNAL_PASSWORD_STORE = "kwallet6";
  };
}
