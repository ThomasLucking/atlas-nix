# Background services for the Mac mini, as launchd user agents.
# Replaces `brew services` for grafana, and adds colima and ollama so they
# come back after a reboot (they didn't before).
{ pkgs, user, ... }:
let
  home = "/Users/${user}";
  logs = "${home}/Library/Logs";
  grafanaData = "${home}/.local/share/grafana";

  # launchd starts agents with a bare PATH; give them the Nix profiles.
  env = {
    HOME = home;
    PATH = "/etc/profiles/per-user/${user}/bin:/run/current-system/sw/bin:/usr/bin:/bin:/usr/sbin:/sbin";
  };
in
{
  # Also on PATH so you can run `colima status`, `ollama run ...`, etc.
  environment.systemPackages = with pkgs; [ colima ollama grafana ];

  launchd.user.agents = {
    grafana.serviceConfig = {
      ProgramArguments = [
        "${pkgs.grafana}/bin/grafana"
        "server"
        "--homepath"
        "${pkgs.grafana}/share/grafana"
        "cfg:default.paths.data=${grafanaData}"
        "cfg:default.paths.plugins=${grafanaData}/plugins"
        "cfg:default.paths.logs=${logs}/grafana"
      ];
      EnvironmentVariables = env;
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "${logs}/grafana.out.log";
      StandardErrorPath = "${logs}/grafana.err.log";
    };

    ollama.serviceConfig = {
      ProgramArguments = [ "${pkgs.ollama}/bin/ollama" "serve" ];
      # Models stay in ~/.ollama.
      EnvironmentVariables = env;
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "${logs}/ollama.out.log";
      StandardErrorPath = "${logs}/ollama.err.log";
    };

    # Uses the existing profile in ~/.colima/default/colima.yaml (2 CPU, 2 GB, vz).
    colima.serviceConfig = {
      ProgramArguments = [ "${pkgs.colima}/bin/colima" "start" "--foreground" ];
      EnvironmentVariables = env;
      RunAtLoad = true;
      # Restart if it crashes, but not after a clean `colima stop`.
      KeepAlive = { SuccessfulExit = false; };
      StandardOutPath = "${logs}/colima.out.log";
      StandardErrorPath = "${logs}/colima.err.log";
    };
  };
}
