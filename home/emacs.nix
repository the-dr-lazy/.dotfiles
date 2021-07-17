{ config, pkgs, ... }:

{
  home.file.".doom.d" = {
    source = ./doom.d;
    recursive = true;
    onChange = ''doom sync'';
  };
}
