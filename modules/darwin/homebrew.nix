# Homebrew, managed declaratively. Off for now: everything you had in brew
# is in Nix. Turn it on for apps that only exist as casks.
{ ... }:
{
  homebrew = {
    enable = false;

    # brews = [ ];
    # casks = [ ];

    # "none" leaves unlisted brew packages alone. "zap" would remove them.
    onActivation.cleanup = "none";
  };
}
