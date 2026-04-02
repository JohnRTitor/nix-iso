{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  nixpkgs.config.allowUnfree = true;
  # Set environment variable for allowing non-free packages
  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ]; # enable nix command and flakes


  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.bcachefs.package = inputs.bcachefs-tools.packages.${pkgs.system}.bcachefs-tools;

  boot.supportedFilesystems = [
    "bcachefs"
  ];

  environment.systemPackages = with pkgs; [
    # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    vim
    git
    curl
    parted
    efibootmgr
  ];

  # Wireless network and wired network is enabled by default
}
