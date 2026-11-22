# Mac mini: the always-on machine. Runs Grafana, Ollama and Colima as services.
{ ... }:
{
  imports = [
    ../../modules/darwin/services.nix
  ];

  # Hostname is deliberately not managed here: changing it would also rename
  # the machine in Tailscale. Set networking.hostName if you ever want Nix to own it.
}
