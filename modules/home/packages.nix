# User-only tools, plus docker CLI plugins so `docker compose` and
# `docker buildx` work (Homebrew used to provide these via cliPluginsExtraDirs).
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Add personal CLI tools here.
    tree
  ];

  home.file.".docker/cli-plugins/docker-compose".source = "${pkgs.docker-compose}/bin/docker-compose";
  home.file.".docker/cli-plugins/docker-buildx".source = "${pkgs.docker-buildx}/bin/docker-buildx";
}
