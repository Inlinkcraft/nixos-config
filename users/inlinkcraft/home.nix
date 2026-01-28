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
    ../../modules/eww
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
    teams-for-linux

    # Wayland utils
    swww
    hyprshot
    wl-clipboard
    grim
    slurp
    cliphist
    swaylock-effects
    swayidle

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

    # Control-center helpers
    networkmanager
    blueman
    pavucontrol
    bluez
    curl

    thunderbird
    remmina
    prusa-slicer

    # Libre office
    libreoffice-qt
    hunspell
    hunspellDicts.fr-any
    hunspellDicts.en_CA
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

  ########################################
  # Swayidle (auto-lock using same script)
  ########################################
  services.swayidle = {
    enable = true;

    timeouts = [
      {
        timeout = 300;
        command = "${config.home.homeDirectory}/.config/eww/scripts/lock";
      }
    ];

    events = {
      before-sleep = "${config.home.homeDirectory}/.config/eww/scripts/lock";
      # optional extras:
      # lock = "${config.home.homeDirectory}/.config/eww/scripts/lock";
      # after-resume = "hyprctl dispatch dpms on";
    };
  };
}
