{
  description = "Unstable NixOS custom installation media";

  # Main sources and repositories
  inputs = {
    nixpkgs.url = "nixpkgs/master"; # Unstable NixOS system (default)
    bcachefs-tools = {
      url = "github:koverstreet/bcachefs-tools";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      system = "x86_64-linux"; # change arch here

      specialArgs = {
        inherit inputs;
      };
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;

      ## GNOME ISO ##
      nixosConfigurations.nixos-gnome = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./graphical-gnome
        ];
        inherit specialArgs;
      };

      ## COSMIC ISO ##
      nixosConfigurations.nixos-cosmic = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./graphical-cosmic
        ];
        inherit specialArgs;
      };
      
      nixosConfigurations.nixos-combined = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./graphical-combined
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

  nixConfig = {
    extra-substituters = [
      "https://devenv.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}