# Replaces ~/.config/fish/config.fish (which only added ~/.local/bin to PATH, twice).
{ ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Commands to run in interactive sessions go here
    '';
  };

  # ~/.local/bin holds the `claude` binary.
  home.sessionPath = [ "$HOME/.local/bin" ];
}
