# git + GitHub CLI. Replaces ~/.config/gh/config.yml.
# Your gh login (~/.config/gh/hosts.yml) is not touched.
{ ... }:
{
  programs.git = {
    enable = true;
    # Fill these in to give commits an author:
    # settings.user.name = "Your Name";
    # settings.user.email = "you@example.com";
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
