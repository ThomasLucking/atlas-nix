# macOS and Nix settings.
{ ... }:
{
  # Nix itself is managed by the Determinate installer, so nix-darwin must not
  # touch the Nix daemon or nix.conf. (With this off, nix.settings does nothing.)
  nix.enable = false;

  # macOS defaults. Nothing is changed yet; uncomment what you want, then switch.
  # Browse all options: https://nix-darwin.github.io/nix-darwin/manual/ (search "system.defaults")
  system.defaults = {
    # dock.autohide = true;
    # dock.show-recents = false;
    # finder.AppleShowAllExtensions = true;
    # finder.FXPreferredViewStyle = "Nlsv";      # list view
    # NSGlobalDomain.KeyRepeat = 2;
    # NSGlobalDomain.InitialKeyRepeat = 15;
  };
}
