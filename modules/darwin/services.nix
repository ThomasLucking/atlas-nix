# Background services for the Mac mini, as launchd user agents.
# Runs colima and ollama so they come back after a reboot.
{ pkgs, user, ... }:
let
  home = "/Users/${user}";
  logs = "${home}/Library/Logs";

  # launchd starts agents with a bare PATH; give them the Nix profiles.
  env = {
    HOME = home;
    PATH = "/etc/profiles/per-user/${user}/bin:/run/current-system/sw/bin:/usr/bin:/bin:/usr/sbin:/sbin";
  };
in
{
  # Also on PATH so you can run `colima status`, `ollama run ...`, etc.
  environment.systemPackages = with pkgs; [ colima ollama ];

  launchd.user.agents = {
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
