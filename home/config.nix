{ config, pkgs, ... }:

{
  home.file = {
    ".config/starship.toml".source = ./config/starship.toml;
    ".alacritty.yml".source = ./config/alacritty.yml;
    ".sqitch/sqitch.conf".source = ./config/sqitch/config.ini;
    ".gitconfig".source = ./config/gitconfig.ini;
    ".doom.d" = {
      source = ./doom.d;
      recursive = true;
      onChange = "doom sync";
    };
    ".config/nixpkgs" = {
      source = ./config/nixpkgs;
      recursive = true;
    };
  };
}
