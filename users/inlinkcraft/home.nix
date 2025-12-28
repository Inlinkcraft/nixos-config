{ pkgs, config, inputs, ... }:

{
  home.username = "inlinkcraft";
  home.homeDirectory = "/home/inlinkcraft";
  home.stateVersion = "24.05";

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
    ../../modules/eww
  ];

  ########################################
  # Packages
  ########################################
  home.packages = with pkgs; [
    firefox
    wofi
    swww
    pywal
    tmux
    ledger
    spotify
    hyprshot
    zoom-us
    discord
    swaylock-effects
    wl-clipboard
    grim
    slurp
    cliphist
    playerctl
    lm_sensors
    procps
    jq
    freecad
  ];

  ########################################
  # Swaylock (or Hyprlock if you want)
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

  home.sessionVariables = {
    QT_QPA_PLATFORM = "xcb";
  };

}
