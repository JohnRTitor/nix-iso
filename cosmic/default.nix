# This module defines a NixOS installation CD that contains Cosmic.

{ lib, pkgs, ... }:

{
  imports = [
    ./cosmic.nix
    ../common.nix
  ];

  networking.hostName = "nixos-cosmic"; # set live session hostname

  # Enable NetworkManager to manage network connections.
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth

  environment.systemPackages = with pkgs; [
    gparted
    google-chrome
  ];
}
