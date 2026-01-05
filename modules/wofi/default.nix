{
  programs.wofi.enable = true;
  home.file.".config/wofi/config".text = ''
    show=dmenu
    prompt=Select theme
    insensitive=true
    allow_images=false
    width=400
    lines=8

    key_up=Up
    key_down=Down
    key_accept=Return
    key_exit=Escape
  '';
}
