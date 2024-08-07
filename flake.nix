# This is a basic NixOS flake template for a live ISO image
# that can be used to install NixOS on a system.
# ISO can be built using
# `nix build .#nixosConfigurations.nixos-iso.config.system.build.isoImage` - Graphical ISO
# `nix build .#nixosConfigurations.nixos-minimal.config.system.build.isoImage` - Minimal ISO
# Make sure to enable flakes and nix-command on the host system, before building the ISO
# Resulting image can be found in ./result/iso/ directory
{
  description = "Unstable NixOS custom installation media";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    bcachefs-tools.url = "github:koverstreet/bcachefs-tools";
  };
  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux"; # change arch here

    specialArgs = {
      inherit system;
      inherit inputs;
    };
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    ## GRAPHICAL ISO ##
    nixosConfigurations.nixos-iso = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
        "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
        ./graphical-configuration.nix
      ];
      inherit specialArgs;
    };
    ## MINIMAL ISO ##
    nixosConfigurations.nixos-minimal = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        ./minimal-configuration.nix
      ];
      inherit specialArgs;
    };
  };

  # Add nix community cache
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
