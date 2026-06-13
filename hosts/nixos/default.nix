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

  boot.tmp.cleanOnBoot = true;

  services.btrfs.autoScrub.enable = true;
  services.btrfs.autoScrub.fileSystems = [ "/" ];
  services.btrfs.autoScrub.interval = "weekly";
  services.gvfs.enable = true;
  services.gvfs.package = pkgs.gnome.gvfs;

  # Firmware stuff.
  services.fwupd.enable = true;

  # Laptop lid config.
  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
  };

  # Fine-grained boot stuff.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModprobeConfig = "options kvm_intel nested=1";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Zram stuff.
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
  };

  # Disk swapfile
  swapDevices = [
    {
      device = "/swapfile";
      size = 8 * 1024;
    }
  ];

  # systemd OOMD
  systemd.oomd = {
    enable = true;
    enableRootSlice = true;
    enableUserSlices = true;
  };

  # amd_pstate (CPU scaling)
  boot.kernelParams = [
    "amd_pstate=active"
    "iommu=pt"
    "idle=nomwait"
  ];

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

  # Graphics
  graphics.enable = true;

  # Virtualization stuff.
  podman.enable = true;
  vm.enable = true;
  vm.kvm.enable = true;
  # vm.waydroid.enable = true;
  virtualisation.vmware.host.enable = false;
  virtualisation.vmware.guest.enable = false;

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
