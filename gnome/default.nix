# This is a basic NixOS configuration template for a live ISO image
# that can be used to install NixOS on a system.
# ISO can be built using `nix build .#nixosConfigurations.nixos-iso.config.system.build.isoImage`
# Make sure to enable flakes and nix-command on the host system before building the ISO
# Resulting image can be found in ./result/iso/ directory
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
    ../common.nix
  ];

  networking.hostName = "nixos-gnome"; # set live session hostname

  # Enable NetworkManager to manage network connections.
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth

  environment.systemPackages = with pkgs; [
    gparted
    google-chrome
  ];
}
