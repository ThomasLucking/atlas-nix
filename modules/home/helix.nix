# Helix had no config files, so this just installs it and makes it $EDITOR.
{ ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    # settings = { theme = "onedark"; editor.line-number = "relative"; };
  };
}
