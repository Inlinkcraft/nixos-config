{
  programs.waybar = {
    enable = true;

    settings = {
      main = {
        layer = "top";
        position = "top";
        height = 20;

        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "network" "pulseaudio" "battery" "tray" ];

        "hyprland/workspaces".format = "{name}";

        "clock" = {
          format = "{:%H:%M:%S}";
          tooltip-format =
            "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
      };
    };
  };
}
