# NixOS ISO Configuration Repository

This repository contains configuration files for building a custom NixOS ISO. The ISO is based on the `nixos-unstable` repository and includes the latest Zen kernel (6.8+) with support for the latest filesystems, including `bcachefs`, `btrfs`, `ext4`.

Two types of ISO can be built:-

* Graphical
* Minimal

See different instructions below.

## Getting Started

This guide assumes that you have `nix` setup in your system or/and are using NixOS.

To build the custom NixOS ISO, follow these steps:

1. Clone this repository to your local machine.
2. Navigate to the repository directory.
3. Run the build command.

```bash
git clone https://github.com/JohnRTitor/nix-iso.git
cd nix-iso
```

### For building full GNOME ISO

```bash
env NIXPKGS_ALLOW_BROKEN=1 nix build .#nixosConfigurations.nixos-gnome.config.system.build.isoImage --impure
```

### For building full Cosmic ISO (EXPERIMENTAL)

```bash
env NIXPKGS_ALLOW_BROKEN=1 nix build .#nixosConfigurations.nixos-cosmic.config.system.build.isoImage --impure
```

### For building minimal ISO

```bash
env NIXPKGS_ALLOW_BROKEN=1 nix build .#nixosConfigurations.nixos-minimal.config.system.build.isoImage --impure
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

## Now, the question is, why?...

A week ago, I had to make an ISO image to support `bcachefs` filesystem because official ISO releases back then did not have the latest kernel.
I quickly looked up the docs, put together a shaky configuration to build it for myself.
Have been using the system with Bcachefs since and it is chill af.
Figured some people might be in a similar situation, so here we are...

I also provide minimal ISO builds via this repo (check Releases). May be outdated though by the time you are reading this, ping me up by creating an issue, I'll provide an updated release ASAP.
