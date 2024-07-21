{ config, pkgs, pkgs-stable, lib, ... }:

{

 #=> NixLD <=#
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

 #=> Packages Installed in System Profile.
 environment.systemPackages = with pkgs; [
 #= Gnome
    #gnome-extension-manager
    #gnomeExtensions.appindicator
    #gnomeExtensions.dash-to-dock
    #gnomeExtensions.blur-my-shell
    #gnomeExtensions.gamemode-indicator-in-system-settings
    #gnomeExtensions.vitals
    #gnomeExtensions.xwayland-indicator
    #gnome.gnome-tweaks
    #gnome.gnome-calculator
    #gnome.dconf-editor
    #gnome.eog
    gnome.nautilus
 #= Hyprland
     #=> Hyprland
    # Terminal
    kitty
    # Top bar
    #eww
    # Hyprland
    hyprland-protocols
    #hyprcursor # The hyprland cursor format, library and utilitie
    # Wayland - Kiosk. Used for login_managers
    cage
    # Notification Deamon
    dunst
    libnotify
    notify
    # Wallpaper
    hyprpaper
    # App-Launcher
    rofi-wayland
    # Applets
    networkmanagerapplet
    # Screen-Locker
    wlogout
    kanshi # To turn a laptop's internal screen off when docked.
    # Lock Screen
    hyprlock
    # Idle manager
    hypridle # required by the screen locker
    # Brightnes Manager
    brightnessctl
    # Media CMD Utility
    playerctl
    #Clipboard-specific
    wl-clipboard-rs
    # Screenshot
    grimblast # Taking
    slurp # Selcting
    swappy # Editing
  #= Polkit
    polkit
    polkit_gnome
    # Image Viewer
    imv
    # Theme's
    adwaita-qt
    adwaita-qt6
    qgnomeplatform
    qgnomeplatform-qt6
    # XWayland/Wayland
    glfw
    wlr-randr
    wayland-utils
    xwayland
    xwayland-run
    xwaylandvideobridge
 #= Main
    alsa-plugins
    alsa-utils
    libsForQt5.ark
    clamtk
    geogebra6
    webcord
    electron
    jq
    python3
    qt5.qtwayland
    qt6.qtwayland
    usbutils
    wget
    libreoffice
    yarn
 #= C/C++
    boost
    cmake
    glibc
    glibmm
    libgcc
    SDL2
 #= XDG
    xdg-utils
    xdg-utils-cxx
    xdg-launch
 #= Cli Utilities
    babelfish
    bat
    eza
    fzf
    ripgrep
    fastfetch
    git
    htop-vim
    zfxtop
    skim
    # Fish Plugins
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
 #= Archives
    imagemagick
    zip
    unzip
    gnutar
    rarcrack
    rar
    unrar-free
 #= Rust
    cargo # PM for rust
    rustup # Rust toolchain installer
 #= Drives utilities
    gnome.gnome-disk-utility # Disk Manager
    ventoy # Flash OS images for Linux and another...
    woeusb # Flash OS images for Windows.
 #= Flatpak
    libportal
    libportal-gtk3
    libportal-gtk4
    libportal-qt5
 #= Graph manager dedicated for PipeWire
    pavucontrol # Pulseaudio Volume Control
    pwvucontrol
 #= Appimages
    appimagekit
    appimage-run
 #= TOR
    #obfs4
    #tor-browser
 #= Image Editors
    krita
    gimp
 #= Video/Audio Tools
    olive-editor # Professional open-source NLE video editor
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vkcapture
        obs-gstreamer
        obs-vaapi
      ];
    })
 #= GStreamer and codecs
    # Video/Audio data composition framework tools like "gst-inspect", "gst-launch" ...
    gst_all_1.gstreamermm # C++ interface for GStreamer
    # Common plugins like "filesrc" to combine within e.g. gst-launch
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-rs # Written in Rust
    # ViPER FX core wrapper plug-in for GStreamer1
    gst_all_1.gst-plugins-viperfx
    # Specialized plugins separated by quality
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    # Plugins to reuse ffmpeg to play almost every video format
    gst_all_1.gst-libav
    # Support the Video Audio (Hardware) Acceleration API
    gst_all_1.gst-vaapi
    # Library for creation of audio/video non-linear editors
    gst_all_1.gst-editing-services
    # H.264 encoder/decoder plugin for mediastreamer2
    mediastreamer-openh264
    # H264/AVC 
    x264 
    # H.265/HEVC
    x265
    # WebM VP8/VP9 codec SDK
    libvpx
    # Vorbis audio compression
    libvorbis
    # Open, royalty-free, highly versatile audio codec
    libopus
    # MPEG
    lame
    # PNG
    libpng
    # JPEG
    libjpeg
    # FFMPEG
    ffmpeg
    ffmpeg-headless
    ffmpegthumbnailer
 #= Media Player
    mpv
 #= Vulkan
    gfxreconstruct
    glslang
    spirv-cross
    spirv-headers
    spirv-tools
    vulkan-extension-layer
    vulkan-headers
    vulkan-loader
    vulkan-tools
    vulkan-tools-lunarg
    vulkan-utility-libraries
    vulkan-validation-layers
    vulkan-volk
    vkdisplayinfo
    vkd3d
    vkd3d-proton
    vk-bootstrap
 #= PC monitoring
    stacer # Linux System Optimizer and Monitoring.
    clinfo
    glxinfo
    hardinfo
    hwinfo
    lm_sensors
    # gaming monitoring
    goverlay
    mangohud
    vkbasalt
 #= Steam Utils
    winetricks
    protontricks
  ];

 #= Java =#
  programs.java = {
    enable = true;
    package = pkgs.jdk;
    binfmt = true;
  };

#==> Flatpak <==#
  services.flatpak.enable = true;

 #= Dbus
  services.dbus = {
    enable = true;
    implementation = "dbus"; 
    packages = with pkgs; [ flatpak ];
  };

#==> Appimages <==#
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

}
