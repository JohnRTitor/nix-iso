# This is a basic NixOS configuration template for a live ISO image
# that can be used to install NixOS on a system.
# ISO can be built using `nix build .#nixosConfigurations.nixos-iso.config.system.build.isoImage`
# Make sure to enable flakes and nix-command on the host system before building the ISO
# Resulting image can be found in ./result/iso/ directory
{
  config,
  lib,
  pkgs,
  system,
  inputs,
  ...
}: {
  nixpkgs.hostPlatform = lib.mkDefault system;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ]; # enable nix command and flakes

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.supportedFilesystems = [
    "btrfs"
    "vfat"
    "f2fs"
    "xfs"
    "ntfs"
    "cifs"
    "bcachefs"
    "ext4"
  ];

  networking.hostName = "nixos-iso"; # set live session hostname

  # Enable NetworkManager to manage network connections.
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth

  nixpkgs.config.allowUnfree = true;
  # Set environment variable for allowing non-free packages
  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    curl
    parted
    google-chrome
    firefox
  ];

  nixpkgs.overlays = [
    (final: prev: {
      bcachefs-tools = inputs.bcachefs-tools.packages.${pkgs.system}.bcachefs-tools;
    })
  ];
}
