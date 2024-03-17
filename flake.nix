{
  description = "Custom NixOS installation media";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
        iso = nixpkgs.lib.nixosSystem {
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


