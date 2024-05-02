# This is a basic NixOS configuration template for a live minimal ISO image
# that can be used to install NixOS on a system.
# ISO can be built using `nix build .#nixosConfigurations.nixos-minimal.config.system.build.isoImage`
# Make sure to enable flakes and nix-command on the host system before building the ISO
# Resulting image can be found in ./result/iso/ directory

{
  config,
  lib,
  pkgs,
  system,
  ...
}:

{
  nixpkgs.hostPlatform = lib.mkDefault system;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ]; # enable nix command and flakes

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.supportedFilesystems = [
    "btrfs"
    "f2fs"
    "xfs"
    "ntfs"
    "bcachefs"
    "ext4"
  ];

  networking.hostName = "nixos-minimal"; # set live session hostname
  # Wireless network and wired network is enabled by default

  nixpkgs.config.allowUnfree = true;
  # Set environment variable for allowing non-free packages
  environment.sessionVariables =  {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  environment.systemPackages = with pkgs; [
    # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    curl
    parted
    firefox
  ];
}
