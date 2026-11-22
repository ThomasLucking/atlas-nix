{
  description = "atlas-nix: nix-darwin + home-manager config for Thomas's Macs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }:
    let
      user = "thomaslucking";

      # Builds one Mac: shared darwin modules + the host's own file + home-manager.
      mkHost = hostModule: nix-darwin.lib.darwinSystem {
        specialArgs = { inherit self user; };
        modules = [
          ./modules/darwin
          hostModule

          home-manager.darwinModules.home-manager
          {
            users.users.${user}.home = "/Users/${user}";

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              # Existing dotfiles (e.g. ~/.config/fish/config.fish) are renamed
              # to *.before-nix instead of blocking the switch.
              backupFileExtension = "before-nix";
              extraSpecialArgs = { inherit user; };
              users.${user} = import ./modules/home;
            };
          }
        ];
      };
    in
    {
      # Names match each Mac's LocalHostName (`scutil --get LocalHostName`),
      # so `darwin-rebuild switch --flake ~/atlas-nix` picks the right one.
      darwinConfigurations = {
        "Thomass-Mac-mini" = mkHost ./hosts/mac-mini;
        "Thomass-MacBook-Pro" = mkHost ./hosts/macbook-pro;
      };
    };
}
