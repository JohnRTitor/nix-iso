{
  description = "Unstable NixOS custom installation media";

  # Main sources and repositories
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable"; # Unstable NixOS system (default)
    bcachefs-tools = {
      url = "github:koverstreet/bcachefs-tools";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Don't add follows nixpkgs, else will cause local rebuilds
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # Bleeding edge packages from chaotic nyx, especially CachyOS kernel
  };

  outputs =
    {
      self,
      nixpkgs,
      chaotic,
      ...
    }@inputs:
    let
      system = "x86_64-linux"; # change arch here

      specialArgs = {
        inherit inputs;
      };
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;

      ## GNOME ISO ##
      nixosConfigurations.nixos-gnome = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./gnome
        ];
        inherit specialArgs;
      };

      ## COSMIC ISO ##
      nixosConfigurations.nixos-cosmic = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./cosmic
        ];
        inherit specialArgs;
      };

      ## MINIMAL ISO ##
      nixosConfigurations.nixos-minimal = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./minimal
        ];
        inherit specialArgs;
      };
    };

  # Allows the user to use our cache when using `nix run <thisFlake>`.
  nixConfig = {
    extra-substituters = [
      "https://nyx.chaotic.cx/"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nyx.chaotic.cx-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
