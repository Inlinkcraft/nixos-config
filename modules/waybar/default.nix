{
  programs.waybar = {
    enable = true;

    settings = {
      main = {
        layer = "top";
        position = "top";
        height = 26;

        modules-left = [
          "hyprland/workspaces"
        ];

        modules-center = [
          "custom/dashboard"
        ];

        modules-right = [
          "pulseaudio"
          "network"
          "clock"
        ];

        "hyprland/workspaces" = {
          format = "{id}";
          disable-scroll = true;
        };

        "custom/dashboard" = {
          format = "00";
          tooltip = false;
          on-click = "hyprctl dispatch togglespecialworkspace dashboard";
        };

        "pulseaudio" = {
          format = "VOL {volume}%";
          tooltip = false;
        };

        "network" = {
          format-wifi = "NET";
          format-ethernet = "ETH";
          format-disconnected = "OFF";
          tooltip = false;
        };

        "clock" = {
          format = "{:%H:%M:%S}";
          tooltip = false;
        };
      };
    };
  };
}
