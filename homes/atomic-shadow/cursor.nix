{ pkgs, ... }:

let
  cursor = pkgs.appimageTools.wrapType2 {
    pname = "cursor";
    version = "2.2.20";
    src = pkgs.fetchurl {
      url = "https://github.com/udit-001/cursor-linux-release/releases/download/v2.2.20/Cursor-2.2.20-x86_64.AppImage";
      sha256 = "1g8a34dvzksfkcyvsj060pwmlhrq97lvmbcdm5dj9v4glqnkd3km";
    };
  };
in
{
  home.packages = [ cursor ];

  xdg.desktopEntries.cursor = {
    name = "Cursor";
    genericName = "AI Code Editor";
    exec = "cursor --ozone-platform-hint=auto %U";
    icon = "/home/atomic-shadow/.dotfiles/homes/atomic-shadow/icons/cursor.webp";
    terminal = false;
    categories = [
      "Development"
      "IDE"
    ];
  };
}
