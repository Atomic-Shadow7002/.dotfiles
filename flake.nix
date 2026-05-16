{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xwayland-satellite = {
      url = "github:Supreeeme/xwayland-satellite";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs:
    let
      system = "x86_64-linux";
      overlay = final: prev: {
        xwayland-satellite = inputs.xwayland-satellite.packages.${system}.default;
      };

      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          inputs.niri.overlays.niri
          inputs.nur.overlays.default
          inputs.nix-alien.overlays.default
          overlay
        ];
      };

      lib = pkgs.lib;

      impure-setup =
        pkgs.writers.writeFishBin "impure-setup" { }
          # fish
          ''
            set CP              '${lib.getExe' pkgs.coreutils "cp"}'
            set GIT             '${lib.getExe pkgs.git}'
            set MKDIR           '${lib.getExe' pkgs.coreutils "mkdir"}'
            set MKTEMP          '${lib.getExe' pkgs.coreutils "mktemp"}'
            set PYWALFOX_NATIVE '${lib.getExe pkgs.pywalfox-native}'
            set RM              '${lib.getExe' pkgs.coreutils "rm"}'
            set LN              '${lib.getExe' pkgs.coreutils "ln"}'

            set ICON_DIR "$HOME/.local/share/icons"
            set REPO_URL 'https://github.com/PapirusDevelopmentTeam/papirus-icon-theme.git'
            set REPO_REV 'c5a48381fce7fda86fb9067fd7816f7de11c0aeb'

            echo '[-*-] Setting up Papirus icon theme.'

            if test -d "$ICON_DIR/Papirus"
              echo "[?] Papirus icon theme already exists as: $ICON_DIR/Papirus"
              echo '    [1] Remove existing theme and re-install.'
              echo '    [2] Skip Papirus icon theme setup.'
              
              read -l -P 'Select an option [1/2*] : ' confirm
              
              switch "$confirm"
                case 1
                  echo '[?] Removing existing Papirus installation.'
                  "$RM" -rf "$ICON_DIR/Papirus"
                case 2
                  echo '[?] Skipping Papirus icon theme setup.'
                  set skip_papirus_installation true
                case '*'
                  echo '[?] Defaulting to: Skip Papirus icon theme setup.'
                  set skip_papirus_installation true
              end
            end

            if not set -q skip_papirus_installation
              echo '[-*-] Fetching Papirus icon theme.'

              "$MKDIR" -p "$ICON_DIR"
              set TMP_DIR ("$MKTEMP" -d)
              
              function cleanup --on-event fish_exit --inherit-variable TMP_DIR
                  "$RM" -rf "$TMP_DIR"
              end

              "$GIT" -c advice.detachedHead=false clone \
                --revision=$REPO_REV \
                --depth=1 \
                --filter=blob:none \
                --sparse "$REPO_URL" "$TMP_DIR"
              "$GIT" -C "$TMP_DIR" sparse-checkout set Papirus

              echo "[-*-] Copying Papirus icon theme to: $ICON_DIR/Papirus"

              "$CP" -r "$TMP_DIR/Papirus" "$ICON_DIR/Papirus"

              echo "[+] Successfully installed Papirus icon theme to: $ICON_DIR/Papirus"
            end

            echo -e '\n[-*-] Setting up pywalfox for LibreWolf.'

            "$PYWALFOX_NATIVE" install --browser librewolf

            "$MKDIR" -p "$HOME/.cache/wal"
            "$LN" -sf "$HOME/.cache/wal/dank-pywalfox.json" "$HOME/.cache/wal/colors.json"

            echo '[+] Successfully setup pywalfox for LibreWolf.'
          '';
    in
    {
      nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs' = pkgs;
        };
        modules = [
          inputs.niri.nixosModules.niri
          ./hosts/nixos
          ./modules/wm
        ];
      };
      homeConfigurations.atomic-shadow = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          inputs.niri.homeModules.config
          inputs.dms.homeModules.niri
          inputs.dms.homeModules.dank-material-shell
          inputs.nix-flatpak.homeManagerModules.nix-flatpak
          ./homes/atomic-shadow
        ];
      };

      packages.${system} = {
        inherit impure-setup;
      };
    };
}
