# This module defines a NixOS installation CD that contains Cosmic.

{ lib, inputs, pkgs, ... }:

{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix"
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/latest-kernel.nix"
    ./cosmic.nix
    ../common.nix
  ];

  networking.hostName = "nixos-cosmic"; # set live session hostname

  # Enable NetworkManager to manage network connections.
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
}
