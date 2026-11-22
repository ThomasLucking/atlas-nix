# User-level config (home-manager) for every Mac.
{ user, ... }:
{
  imports = [
    ./fish.nix
    ./helix.nix
    ./git.nix
    ./packages.nix
  ];

  home.username = user;
  home.homeDirectory = "/Users/${user}";

  # Read the home-manager release notes before ever changing this.
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
