{ pkgs, lib, ... }:

let
  primaryUser = "the-dr-lazy";
in
{
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  imports = [ ./homebrew.nix ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.nixpkgs/darwin.nix";

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    allowUnsupportedSystem = false;
  };

  # Auto upgrade nix package and the daemon service.
  nix = {
    package = pkgs.nixFlakes;
    binaryCachePublicKeys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
      "the-dr-lazy.cachix.org-1:TI5TClLAkhXY4ACaTHO3/H1XUxuf85HBxz8AHlNVgHM="
      "haskell-language-server.cachix.org-1:juFfHrwkOxqIOZShtC4YC1uT1bBcq2RSvC7OMKx0Nz8="
    ];
    binaryCaches = [
      "https://hydra.iohk.io"
      "https://iohk.cachix.org"
      "https://the-dr-lazy.cachix.org"
      "https://haskell-language-server.cachix.org"
    ];
    trustedUsers = [ "root" "@admin" ];
    gc.automatic = true;
    gc.user = primaryUser;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true

      experimental-features = nix-command flakes
    '';
    useDaemon = true;
  };

  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];

  services.nix-daemon.enable = false;

  # `home-manager`
  users.users.${primaryUser}.home = "/Users/the-dr-lazy";
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${primaryUser} = import ../home;

  # Hack: There is an issue with order of PATHs. The nix profile bin PATH comes too late!
  # See https://github.com/LnL7/nix-darwin/issues/122
  environment.etc."fish/nixos-env-preinit.fish".text = lib.mkMerge [
    (lib.mkBefore ''
      set -l oldPath $PATH
    '')
    (lib.mkAfter ''
      for elt in $PATH
        if not contains -- $elt $oldPath /usr/local/bin /usr/bin /bin /usr/sbin /sbin
          set -ag fish_user_paths $elt
        end
      end
      set -el oldPath
    '')
  ];
}
