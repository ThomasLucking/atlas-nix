# atlas-nix

nix-darwin + home-manager config for both Macs.

| Host | Config name | Gets |
|---|---|---|
| Mac mini | `Thomass-Mac-mini` | shared packages + dotfiles + Grafana, Ollama, Colima services |
| MacBook Pro | `Thomass-MacBook-Pro` | shared packages + dotfiles |

## Everyday use

```sh
sudo darwin-rebuild switch --flake ~/atlas-nix   # apply changes
nix flake update --flake ~/atlas-nix              # bump all inputs, then switch
sudo darwin-rebuild --rollback                    # undo the last switch
```

Flakes only see files tracked by git, so `git add` new files before switching.

## Fresh Mac

1. Install Nix: `curl -fsSL https://install.determinate.systems/nix | sh -s -- install`
2. Clone this repo to `~/atlas-nix`.
3. First switch (darwin-rebuild isn't installed yet):
   `sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/atlas-nix`
4. Optional: make Nix's fish your login shell: `chsh -s /run/current-system/sw/bin/fish`

## Service logs

`~/Library/Logs/{grafana,ollama,colima}.{out,err}.log`
Status: `launchctl list | grep org.nixos`

## Where data lives

- Grafana: `~/.local/share/grafana` (copied from `/opt/homebrew/var/lib/grafana`)
- Ollama models: `~/.ollama`
- Colima VM + profile: `~/.colima`
