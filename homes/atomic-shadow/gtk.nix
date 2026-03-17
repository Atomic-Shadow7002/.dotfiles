{ pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  dconf.enable = true;

  home.packages = with pkgs; [
    nautilus
    adw-gtk3
    papirus-icon-theme
    papirus-folders
  ];

  home.sessionVariables = {
    GDK_BACKEND = "wayland";
  };

}
