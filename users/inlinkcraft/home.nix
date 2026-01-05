{ pkgs, config, inputs, ... }:
let
  hyproled = pkgs.stdenvNoCC.mkDerivation {
    pname = "hyproled";
    version = "0.1.3";

    src = pkgs.fetchFromGitHub {
      owner = "mklan";
      repo = "hyproled";
      rev = "0.1.3"; # if this tag doesn't exist, switch to the release tag name in the repo
      hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };

    dontBuild = true;
    installPhase = ''
      install -Dm755 hyproled $out/bin/hyproled
    '';
  };
in
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

    # Wayland utils
    swww
    hyprshot
    wl-clipboard
    grim
    slurp
    cliphist
    swaylock-effects
    swayidle
    hyproled

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
  # screensaver ?
  ########################################
  home.file."Configuration/scripts/oled-saver" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      set -euo pipefail
  
      HYPROLED="${hyproled}/bin/hyproled"
  
      # Only run if swaylock is actually active
      if ! pgrep -x swaylock >/dev/null 2>&1; then
        exit 0
      fi
  
      # Prevent multiple copies
      LOCKFILE="''${XDG_RUNTIME_DIR:-/tmp}/oled-saver.lock"
      exec 9>"$LOCKFILE"
      if ! ${pkgs.util-linux}/bin/flock -n 9; then
        exit 0
      fi
  
      # Turn on + keep shifting pattern while locked
      # (Default area is the whole screen; use -a x:y:w:h to limit if you want.) :contentReference[oaicite:3]{index=3}
      "$HYPROLED" -s || true
  
      while pgrep -x swaylock >/dev/null 2>&1; do
        sleep 30
        "$HYPROLED" -s || true
      done
  
      # Unlocked -> disable shader
      "$HYPROLED" off || true
    '';
  };

  services.swayidle = {
    enable = true;
  
    timeouts = [
      # 5 min -> lock (your existing lock script)
      {
        timeout = 300;
        command = "$HOME/Configuration/scripts/lock";
      }
  
      # 10 min -> start OLED saver mode (keeps lockscreen; shifts pixels)
      {
        timeout = 600;
        command = "$HOME/Configuration/scripts/oled-saver";
      }
    ];
  
    events = [
      { event = "before-sleep"; command = "$HOME/Configuration/scripts/lock"; }
    ];
  };

  home.file."Configuration/scripts/lock" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      set -euo pipefail

      # Avoid stacking multiple locks
      if pgrep -x swaylock >/dev/null 2>&1; then
        exit 0
      fi

      WALLPAPER_FILE="$HOME/.cache/current-wallpaper"
      WAL_FILE="$HOME/.cache/wal/colors.sh"

      IMAGE=""
      if [[ -f "$WALLPAPER_FILE" ]]; then
        IMAGE="$(head -n 1 "$WALLPAPER_FILE" || true)"
      fi

      # Defaults
      ring="88c0d0"
      keyhl="a3be8c"
      inside="00000088"
      line="00000000"
      sep="00000000"
      text="ffffffff"

      # If pywal exists, use it (strip leading '#', append alpha where needed)
      if [[ -f "$WAL_FILE" ]]; then
        # shellcheck disable=SC1090
        source "$WAL_FILE"

        strip() { echo "''${1#\#}"; }

        # Common pywal vars: background, foreground, color1, color2, etc.
        ring="$(strip "''${color1:-#88c0d0}")"
        keyhl="$(strip "''${color2:-#a3be8c}")"
        inside="$(strip "''${background:-#000000}")88"
        text="$(strip "''${foreground:-#ffffff}")ff"
      fi

      SWAYLOCK="${pkgs.swaylock-effects}/bin/swaylock"

      if [[ -n "$IMAGE" && -f "$IMAGE" ]]; then
        exec "$SWAYLOCK" \
          --image "$IMAGE" \
          --scaling fill \
          --clock \
          --indicator \
          --effect-blur 7x5 \
          --effect-vignette 0.5:0.5 \
          --ring-color "$ring" \
          --key-hl-color "$keyhl" \
          --inside-color "$inside" \
          --line-color "$line" \
          --separator-color "$sep" \
          --text-color "$text"
      else
        # Fallback: lock from a blurred screenshot
        exec "$SWAYLOCK" \
          --screenshots \
          --clock \
          --indicator \
          --effect-blur 7x5 \
          --effect-vignette 0.5:0.5 \
          --ring-color "$ring" \
          --key-hl-color "$keyhl" \
          --inside-color "$inside" \
          --line-color "$line" \
          --separator-color "$sep" \
          --text-color "$text"
      fi
    '';
  };
}
