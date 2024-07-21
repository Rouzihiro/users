{ config, pkgs, lib, inputs, ... }:

{
#====> GAMING <====#

#= Scheduler SCX
  chaotic.scx.enable = true;
  chaotic.scx.package = pkgs.scx;
  chaotic.scx.scheduler = "scx_rustland";

#= IRQBalance
  services.irqbalance.enable = lib.mkDefault true;

#= Ananicy
  services.ananicy.enable = true;
  services.ananicy.package = pkgs.ananicy-cpp;
  services.ananicy.rulesProvider = pkgs.ananicy-rules-cachyos;

#=> Gamescope
  programs.gamescope = {
    enable = true;
    package = pkgs.gamescope;
    capSysNice = false;
  };

#=> Gamemode
  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        renice = 10;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        amd_performance_level = "high";
      };
      cpu = {
        park_cores = "no";
        pin_cores = "yes";
      };
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode Started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode Ended'";
      };
    };
  };

#=> Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    extest.enable = true; # For using Steam Input on Wayland
    extraCompatPackages = [
      pkgs.proton-ge-bin # GloriousEggroll custom Proton
    ];
  };

#= CORECTRL (Overclock).
  programs.corectrl.enable = true;

#=> OPENGL and more... 
  
  #= Mesa-Git
  chaotic.mesa-git.enable = true;
  chaotic.mesa-git.extraPackages = with pkgs; [
      mesa_git.opencl
      libdrm_git
      vaapiVdpau
      vdpauinfo
      libvdpau
      libvdpau-va-gl
  ];
  chaotic.mesa-git.extraPackages32 = with pkgs.pkgsi686Linux; [
      pkgs.mesa32_git.opencl
      libdrm32_git
      glxinfo
      vaapiVdpau
      vdpauinfo
      libvdpau-va-gl
  ];

  hardware.cpu.amd.updateMicrocode = true;

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true; 
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.setLdLibraryPath = true;

  hardware.steam-hardware.enable = true;
  
  hardware.enableAllFirmware = true;
  
  hardware.enableRedistributableFirmware = true; # Lemme update my CPU Microcode, alr?!

#= FWUPD
  services.fwupd.enable = true;
}
