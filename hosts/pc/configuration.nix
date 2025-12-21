{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../users/inlinkcraft/host.nix
  ];

  networking.hostName = "pc";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ###############################################################
  # NETWORK
  ###############################################################
  networking.networkmanager.enable = true;

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  ###############################################################
  # NVIDIA + Wayland
  ###############################################################
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vdpauinfo
      libva-utils
      nvidia-vaapi-driver
    ];
  };

  hardware.nvidia = {
    open = true;
    powerManagement.enable = true;
    modesetting.enable = true;
    nvidiaSettings = true;
  };

  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  ###############################################################
  # Hyprland
  ###############################################################
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  ###############################################################
  # greetd (Wayland login)
  ###############################################################
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
      user = "inlinkcraft";
    };
  };

  ###############################################################
  # Audio (PipeWire)
  ###############################################################
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  ###############################################################
  # Printing
  ###############################################################
  services.printing.enable = true;

  ###############################################################
  # Console keymap
  ###############################################################
  console.keyMap = "cf";

  ###############################################################
  # Fonts
  ###############################################################
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  ###############################################################
  # Wayland portals
  ###############################################################
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  ###############################################################
  # Unfree packages
  ###############################################################
  nixpkgs.config.allowUnfree = true;


  programs.thunar.enable = true;

  ###############################################################
  # System version
  ###############################################################
  system.stateVersion = "25.05";
}
