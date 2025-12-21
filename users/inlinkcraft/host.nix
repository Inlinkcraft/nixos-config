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
      thunar
    ];

  };
}

