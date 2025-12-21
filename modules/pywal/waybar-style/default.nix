{
  programs.waybar = {
    style = ''
      @import "/home/inlinkcraft/.cache/wal/colors-waybar.css";

      #waybar {
        background: @background;
        color: @foreground;
      }
    '';
  };
}

