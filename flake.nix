{
  description = "Inlinkcraft's config";

  inputs = {
    
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

  };
  
  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs: 
  {
    nixosModules = {
      
      default = { config, pkgs, ... }: {
        imports = [
          ./hosts/pc/configuration.nix
          home-manager.nixosModules.home-manager
          {    
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.inlinkcraft = {    
              home.username = "inlinkcraft";
              home.homeDirectory = "/home/inlinkcraft";
              home.stateVersion = "24.05";
              imports = [ ./users/inlinkcraft.nix ];  
            };
          }
        ];
      };

      laptop = { config, pkgs, ...}: {
        imports = [
          ./hosts/laptop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.inlinkcraft = {
              home.username = "inlinkcraft";
              home.homeDirectory = "/home/inlinkcraft";
              home.stateVersion = "24.05";                
              imports = [ ./users/inlinkcraft.nix ];
            };
          }
        ];
      };

    };
  };
}
