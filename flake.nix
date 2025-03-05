{
  description = "Configuration MacOs";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/master";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixvim, home-manager, nix-homebrew, ... }:
    let
      username  = "87labs";
      hostname  = "MacBook-Pro-de-Gustavo";
      system    = "aarch64-darwin";
      useremail = "gustavorosawinter@gmail.com";

      nixvimModule = nixvim.homeManagerModules.nixvim;

      specialArgs =
        inputs
        // {
          inherit username hostname system useremail;
        };
    in
      {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#MacBook-Pro-de-Gustavo
      darwinConfigurations."${hostname}" = nix-darwin.lib.darwinSystem {
        inherit system specialArgs;
        modules = [
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              user = username; # "87labs"
              autoMigrate = true; # Migrate existing Homebrew if present
            };
            # Ensure the user exists in the system configuration
            users.users.${username} = {
              home = "/Users/${username}";
            };
            # Enable Zsh integration (since you're using Zsh)
            programs.zsh.enable = true;
            # Enable experimental features for flakes
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
            # Set the nixbld group GID to 350 to match the system's actual GID.
            # This is necessary because newer Nix installations on macOS use GID 350
            # instead of the historical default of 30000, and nix-darwin expects the
            # configured GID to align with the system's value. Without this, activation
            # fails due to a GID mismatch error during darwin-rebuild.
            ids.gids.nixbld = 350;
          }
          ./modules/nix-core.nix
          ./modules/apps.nix
          ./modules/system.nix
          ./modules/host-users.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = { 
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = specialArgs;
              users.${username} = { config, lib, pkgs, ... }: {
                imports = [
                  ./home
                  nixvimModule
                ];
              };
            };  
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."${hostname}".pkgs;
    };
}