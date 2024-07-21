{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./essentials.nix
      ./thunar.nix
      #./flatpak.nix
    ];

}

