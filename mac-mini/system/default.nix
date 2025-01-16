{ pkgs, lib, config, ... }:

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

  # Auto upgrade nix package and the daemon service.
  nix = {
    package = pkgs.nixVersions.stable;
    settings = {
      substituters = [
        "https://cache.iog.io"
        "https://iohk.cachix.org"
        "https://the-dr-lazy.cachix.org"
        "https://haskell-language-server.cachix.org"
        "https://cache.ngi0.nixos.org"
      ];
      trusted-public-keys = [
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
        "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
        "the-dr-lazy.cachix.org-1:TI5TClLAkhXY4ACaTHO3/H1XUxuf85HBxz8AHlNVgHM="
        "haskell-language-server.cachix.org-1:juFfHrwkOxqIOZShtC4YC1uT1bBcq2RSvC7OMKx0Nz8="
        "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
      ];
      trusted-users = [ "root" "@admin" ];
    };
    gc.automatic = true;
    gc.user = primaryUser;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true

      experimental-features = nix-command flakes ca-derivations
    '';
    useDaemon = true;
  };

  programs.fish = {
    enable = true;

    loginShellInit =
      let
        # This naive quoting is good enough in this case. There shouldn't be any
        # double quotes in the input string, and it needs to be double quoted in case
        # it contains a space (which is unlikely!)
        dquote = str: "\"" + str + "\"";

        makeBinPathList = map (path: path + "/bin");
      in ''
        fish_add_path --move --prepend --path ${lib.concatMapStringsSep " " dquote (makeBinPathList config.environment.profiles)}
        set fish_user_paths $fish_user_paths
      '';
  };
  programs.zsh.enable = true;
  environment.shells = [ pkgs.fish ];

  services.nix-daemon.enable = true;

  # `home-manager`
  users.users.${primaryUser}.home = "/Users/the-dr-lazy";
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${primaryUser} = import ../home;
}
