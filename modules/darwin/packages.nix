# CLI tools on every Mac. Replaces these Homebrew formulae:
# ansible, docker, docker-buildx, docker-compose, node@24, wget.
# (fish, gh and helix are set up in modules/home; colima, ollama and grafana in services.nix.)
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ansible
    docker-client
    docker-buildx
    docker-compose
    nodejs_24
    wget
  ];

  # Puts Nix's paths into fish's environment and lets fish be a login shell.
  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];
}
