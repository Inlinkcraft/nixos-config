{ pkgs, config, ... }:

{
  imports = [
    ../modules/wayland
    ../modules/nvim
    ../modules/kitty
    ../modules/waybar
    ../modules/wofi
    ../modules/pywal
    ../modules/pywal/hyprland-style
    ../modules/pywal/waybar-style
    ../modules/pywal/wodi-style
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
}
