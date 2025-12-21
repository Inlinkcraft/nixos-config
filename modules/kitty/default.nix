{
  programs.kitty = {
    enable = true;

    extraConfig = ''
      include ~/.cache/wal/colors-kitty.conf
      allow_remote_control yes
    '';
  };
}
