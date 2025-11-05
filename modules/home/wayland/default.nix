{ config, pkgs, inputs, ...}:
{
  wayland.windowManager.hyprland = {
  
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    settings = {

      monitor = [ 
        "eDP-1,1920x1080@60,0x0,1"
	"HDMI-A-3,1920x1080@60,0x0,1"
	"DP-3,1920x1080@60,1920x0,1"
      ];

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

	"SUPER_CTRL,H,resizeactive,-10 0"
	"SUPER_CTRL,L,resizeactive,10 0"
	"SUPER_CTRL,J,resizeactive,0 -10"
	"SUPER_CTRL,K,resizeactive,0 10"

        "SUPER,B,exec,pkill -SIGUSR1 waybar || wa<D-v>ybar"
	"SUPER,T,exec,teams-for-linux"
	"SUPER,N,exec,alacritty -e nvim"

	"SUPER_SHIFT,I,togglefloating"
	
	"SUPER,P,exec,hyprshot -m window -m active --clipboard-only"
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
     
      windowrule = [
	"nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
	"suppressevent maximize, class:.*"
      ];

    };

  };

}
