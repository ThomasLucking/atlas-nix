# Always-on server behaviour: never sleep, come back by itself after power
# loss or a freeze, and stay reachable on the network.
{ ... }:
{
  power = {
    sleep = {
      computer = "never";
      # The screen may still turn off; that does not put the Mac to sleep.
      display = 10;
      harddisk = "never";
      # A bumped power button should not take the server offline.
      allowSleepByPowerButton = false;
    };
    restartAfterPowerFailure = true;
    restartAfterFreeze = true;
  };

  # Wake for network access (Wake-on-LAN / Bonjour sleep proxy).
  networking.wakeOnLan.enable = true;

  # macOS upgrades reboot the machine on their own schedule. With FileVault on,
  # it then stops at the unlock screen and nothing runs until someone logs in.
  # Security responses and system data files still install automatically.
  system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;

  # pmset settings nix-darwin has no option for. -a = every power source.
  system.activationScripts.postActivation.text = ''
    echo "configuring server power settings..." >&2
    pmset -a sleep 0          # never sleep the system
    pmset -a disksleep 0      # never spin down disks
    pmset -a standby 0        # no deep standby
    pmset -a powernap 0       # no half-asleep Power Nap state
    pmset -a autorestart 1    # boot after power returns
    pmset -a womp 1           # wake on network packet
    pmset -a tcpkeepalive 1   # keep TCP connections alive
    pmset -a ttyskeepawake 1  # open SSH sessions keep it awake
  '';
}
