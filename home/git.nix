{ config, pkgs, ... }:

{
  home.file.".gitconfig".source = ./config/gitconfig.ini;
  
  home.packages = with pkgs; [ gitFull ];
}
