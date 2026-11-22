# MacBook Pro: gets the shared packages and dotfiles, but none of the mini's services.
# Before the first switch there, check that `scutil --get LocalHostName` prints
# "Thomass-MacBook-Pro"; if not, rename the entry in flake.nix to match.
{ ... }:
{
  # Laptop-only settings go here.
}
