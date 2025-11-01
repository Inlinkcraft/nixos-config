{ config, pkgs, inputs, ...}:
{
  wayland.windowManager.hyprland = {
  
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    settings = {

      monitor = [ "eDP-1,1920x1080@60,0x0,1" ];

      # Just a couple of basic binds
      bind = [
        "SUPER,Return,exec,alacritty"
        "SUPER,Q,killactive,"
	"SUPER,F,exec,firefox"
        "SUPER,SPACE,exec,wofi --show drun"

        "SUPER,H,movefocus,l"
        "SUPER,L,movefocus,r"
        "SUPER,K,movefocus,u"
        "SUPER,J,movefocus,d"

        "SUPER_SHIFT,H,movewindow,l"
        "SUPER_SHIFT,L,movewindow,r"
        "SUPER_SHIFT,K,movewindow,u"
        "SUPER_SHIFT,J,movewindow,d"

        "SUPER,B,exec,pkill -SIGUSR1 waybar || waybar"
	"SUPER,T,exec,teams-for-linux"
	"SUPER,N,exec,alacritty -e nvim"

      ];

      input = {
        kb_layout = "ca";
	kb_options = caps:escape;
      };

      exec-once = [
	"swww-daemon"
        "swww img /home/inlinkcraft/Wallpapers/Master_sword.jpg"
        "waybar"
        "wofi --show drun"
      ];

    };

  };

}
