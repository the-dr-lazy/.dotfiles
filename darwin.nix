{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.nixpkgs/darwin.nix";

  # Auto upgrade nix package and the daemon service.
  nix = {
    package = pkgs.nix;
    binaryCachePublicKeys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
    ];
    binaryCaches = [
      "https://hydra.iohk.io"
      "https://iohk.cachix.org"
      "https://the-dr-lazy.cachix.org"
    ];
    trustedUsers = [ "root" "the-dr-lazy" ];
  };

  programs.fish.enable = true;

  services.nix-daemon.enable = false;
  services.lorri.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
