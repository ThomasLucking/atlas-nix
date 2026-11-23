# git + GitHub CLI. Replaces ~/.config/gh/config.yml.
# Your gh login (~/.config/gh/hosts.yml) is not touched.
{ ... }:
{
  programs.git = {
    enable = true;
    settings.user.name = "Thomas Lucking";
    settings.user.email = "ciec24067@gmail.com";
  };

  programs.gh = {
    enable = true;
    # Lets git use your gh login for https pushes/pulls.
    gitCredentialHelper.enable = true;
    settings = {
      git_protocol = "https";
      aliases = {
        co = "pr checkout";
      };
    };
  };
}
