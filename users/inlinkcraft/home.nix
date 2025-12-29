{ pkgs, config, inputs, ... }:

{
  home.username = "inlinkcraft";
  home.homeDirectory = "/home/inlinkcraft";
  home.stateVersion = "24.05";

  ########################################
  # Imports (modules)
  ########################################
  imports = [
    ../../modules/wayland
    ../../modules/nvim
    ../../modules/kitty
    ../../modules/waybar
    ../../modules/wofi
    ../../modules/pywal
    ../../modules/pywal/hyprland-style
    ../../modules/pywal/waybar-style
    ../../modules/pywal/wofi-style
    ../../modules/ags
#    ../../modules/eww
  ];

  ########################################
  # Packages
  ########################################
  home.packages = with pkgs; [
    # Browsers / apps
    firefox
    spotify
    zoom-us
    discord
    freecad

    # Wayland utils
    swww
    hyprshot
    wl-clipboard
    grim
    slurp
    cliphist
    swaylock-effects

    # CLI / tools
    tmux
    ledger
    fastfetch
    cava
    jq
    socat
    procps

    # Media / control
    playerctl
    pamixer
    brightnessctl
    acpi
    lm_sensors

    # UI / theming
    pywal
    nerd-fonts.fira-code

    # AGS runtime deps (GTK4)
    ags
    bun
    gjs
    gtk4
    gtk4-layer-shell

    # Control-center helpers
    networkmanager
    blueman
    pavucontrol
  ];

  ########################################
  # Swaylock
  ########################################
  programs.swaylock.settings = {
    color = "#00000000";
  };

  ########################################
  # Direnv
  ########################################
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  ########################################
  # FreeCAD wrapper (Wayland fix)
  ########################################
  home.file.".local/bin/freecad".text = ''
    #!${pkgs.stdenv.shell}
    export QT_QPA_PLATFORM=xcb
    exec ${pkgs.freecad}/bin/FreeCAD "$@"
  '';
}
