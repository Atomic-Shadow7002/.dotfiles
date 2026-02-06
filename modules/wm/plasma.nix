{ pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = [
    pkgs.kdePackages.kate
    pkgs.kdePackages.elisa
    pkgs.kdePackages.khelpcenter
  ];
}
