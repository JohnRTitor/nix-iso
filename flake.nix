# This is a basic NixOS flake template for a live ISO image
# that can be used to install NixOS on a system.
# ISO can be built using `nix build .#nixosConfigurations.nixos-iso.config.system.build.isoImage`
# Make sure to enable flakes and nix-command on the host system, before building the ISO
# Resulting image can be found in ./result/iso/ directory

{
  description = "Unstable NixOS custom installation media";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
        nixos-iso = nixpkgs.lib.nixosSystem {
            modules = [
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
            "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
            ./configuration.nix
            ];
            # specialArgs = {inherit inputs outputs;};
        };
    };
  };
}


