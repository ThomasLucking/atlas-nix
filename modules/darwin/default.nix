# System-level config shared by every Mac.
{ self, user, ... }:
{
  imports = [
    ./packages.nix
    ./system.nix
    ./homebrew.nix
    ./netbird.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  # Options that act on a user (defaults, homebrew, launchd user agents) apply to this account.
  system.primaryUser = user;

  # Shows which git commit is deployed: `darwin-version --configuration-revision`.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Read the nix-darwin changelog before ever changing this.
  system.stateVersion = 6;
}
