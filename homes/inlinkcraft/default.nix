
{ pkgs, ... }: {
  
  imports = [
    ./../../modules/home/wayland/default.nix
  ];

  home.packages = with pkgs; [
    alacritty
    firefox
    waybar
    wofi
    swww
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set number
      set number relativenumber
      syntax enable
      colorscheme gruvbox
    '';
  };

}
