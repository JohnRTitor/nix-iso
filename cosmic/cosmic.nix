# This module defines a NixOS installation CD that contains Cosmic.

{ lib, inputs, ... }:

{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-base.nix"
  ];

  isoImage.edition = lib.mkDefault "cosmic";

  services.desktopManager.cosmic = {
    enable = true;
    xwayland.enable = true;
  };

  services.displayManager.cosmic-greeter.enable = true;

  services.displayManager.autoLogin = {
    enable = true;
    user = "nixos";
  };
}
