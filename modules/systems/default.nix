{ lib, pkgs, config, modulesPath, ... }:

with lib;

let
  nixos-wsl = import ./wsl;
in

{
  imports = [
    "${modulesPath}/profiles/minimal.nix"

    nixos-wsl.nixosModules.wsl
    ./config
  ];

  wsl = {
    enable = true;
    automountPath = "/mnt";
    defaultUser = "ms";
    startMenuLaunchers = true;

    # Enable native Docker support
    docker-native.enable = true;

    # Enable integration with Docker Desktop (needs to be installed)
    # docker-desktop.enable = true;

  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.ms.extraGroups =  [ "wheel" "docker" "libvirtd" "networkmanager" "plugdev" ];  
  };

  networking.hostName = "beast";

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "22.05";
}
