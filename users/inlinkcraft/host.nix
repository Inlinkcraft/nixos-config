{ pkgs, ... }:

{
  users.users.inlinkcraft = {
    isNormalUser = true;
    description = "Inlinkcraft";
    home = "/home/inlinkcraft";
    shell = pkgs.bash;
    extraGroups = [ "wheel" "networkmanager" ];

    packages = with pkgs; [
      git
      swww
      cifs-utils
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };
}

