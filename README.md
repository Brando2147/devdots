<img src="https://user-images.githubusercontent.com/1292576/190241835-41469235-f65d-4d4b-9760-372cdff7a70f.png" width="48">

# Brando's Nix / NixOS config
![GitHub last commit](https://img.shields.io/github/last-commit/brando2147/nixos-config?style=plastic)

# Overview
 
Immutable, reproducible infrastructure, 
  I keep filename conventions the same across modules. I've included step-by-step instructions on bootstrapping a new machine below.

 
#  (NixOS) Features
* Multiple Nix and NixOS configurations, including desktop, laptop, server
* [Step-by-step instructions](https://github.com/brando2147/devdots/tree/main#bootstrap-new-computer) to start from zero, both x86 and MacOS platforms
* Fully declarative [MacOS dock](https://github.com/brando2147/devdots/blob/main/darwin/home-manager.nix) and MacOS [App Store apps](https://github.com/brando2147/devdots/blob/main/darwin/home-manager.nix)
* Defined using a [single flake](https://github.com/brando2147/devdots/blob/main/flake.nix) and two targets, not small files spread across collections of modules
* Fully managed, auto-updating [homebrew](https://github.com/brando2147/devdots/blob/main/darwin/home-manager.nix) environment
* Easily [share](https://github.com/brando2147/devdots/tree/main/common) config across Linux and Mac with both Nix and Home Manager
* Minimal [shell scripts](https://github.com/brando2147/devdots/tree/main/bin) covering basic functions for running systems
* Bleeding edge Emacs that fixes itself, thanks to a community [overlay](https://github.com/nix-community/emacs-overlay)
* Extensively configured NixOS environment including clean aesthetic + [window animations](https://github.com/brando2147/devdots/blob/main/nixos/default.nix)
* Auto-loading of Nix [overlays](https://github.com/brando2147/devdots/tree/main/overlays): drop a file in a dir and it runs _(great for patches!)_
* Large Emacs [literate configuration](https://github.com/brando2147/devdots/blob/main/common/config/emacs/config.org) to explore (if that's your thing)
* Optimized for simplicity and readability in all cases

 
# Layout

```
.
├── bin          # Simple scripts used to wrap the build
├── common       # Shared configurations applicable to all machines
├── hardware     # Hardware-specific configuration
├── darwin       # MacOS and nix-darwin configuration
├── nixos        # My NixOS desktop-related configuration
├── overlays     # Drop an overlay file in this dir, and it runs. So far mainly patches.
└── vms          # VM-specific configs running in my home-lab
```

# Bootstrap New Computer

## Step 1 - For MacOS, install Nix package manager
Install the nix package manager, add unstable channel:
```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
```
```sh
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
```
```sh
nix-channel --update
```

## Step 2 - For NixOS, create a disk partition and install media
Follow this [step-by-step guide](https://github.com/brando2147/devdots/blob/main/vm/README.md) for instructions to install using `ZFS` or `ext3`.


## Step 3 - Install home-manager
Add the home-manager channel and install it:
```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
```
```sh
nix-channel --update
```

## Step 4 - If MacOS, install Darwin dependencies
Install Xcode CLI tools and nix-darwin:
```sh
xcode-select --install
```
```sh
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
```
```sh
./result/bin/darwin-installer
```

## Step 5 - Build the environment
Download this repo and run:
```sh
./bin/build
```

## Step 6 - Reboot computer
That's it. You're done.

# Update Computer

## Download the latest updates and update lock file
```sh
nix flake update
```
## Run  build
```sh
./bin/build
```