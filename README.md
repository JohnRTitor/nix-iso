# NixOS ISO Configuration Repository

This repository contains configuration files for building a custom NixOS ISO. The ISO is based on the `nixpkgs-unstable` repository and includes the latest Zen kernel with support for the latest filesystems, including `bcachefs`.


## Getting Started

This guide assumes that you have `nix` setup in your system or/and are using NixOS.

To build the custom NixOS ISO, follow these steps:

1. Clone this repository to your local machine.
2. Navigate to the repository directory.
3. Run the build command.

```bash
git clone <repository-url>
cd <repository-directory>
nix build .#nixosConfigurations.nixos-iso.config.system.build.isoImage
```

Ensure that flakes and nix-command are enabled on the host system before building the ISO.

The resulting ISO image can be found in the `./result/iso/` directory.

## License

The configuration files in this repository are licensed under the Apache 2.0 License. However, softwares used in conjunction with these configuration files are owned by their respective owners. Please ensure to comply with the licensing terms of all used software.

## Contributing

Contributions to this repository are welcome. Please feel free to open an issue or submit a pull request.

## Disclaimer

While every effort has been made to ensure these configuration files work as expected, they are provided "as is". Please use at your own risk.

Please note that this guide assumes you have a basic understanding of NixOS and the Nix package manager. If you are new to Nix or NixOS, you may want to check out the [Nix manual](https://nixos.org/manual/nix/stable/) for more information.