{
  home.file.".config/wofi/style.css".text = ''
    @import "/home/inlinkcraft/.cache/wal/colors-waybar.css";

    * {
      font-family: "JetBrainsMono Nerd Font";
      font-size: 14px;
    }

    window {
      background-color: rgba(18, 18, 18, 0.97);
      color: @foreground;
      border: 2px solid @color4;
      border-radius: 12px;
      padding: 12px;
    }

    #input {
      margin: 6px;
      padding: 6px;
      border-radius: 6px;
      background-color: @color0;
      color: @foreground;
    }

    #inner-box {
      margin-top: 8px;
    }

    #entry {
      padding: 8px;
      border-radius: 6px;
    }

    #entry:selected {
      background-color: @color4;
      color: @background;
      border-left: 4px solid @color2;
      padding-left: 6px;
    }
  '';
}
