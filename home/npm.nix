{ config, lib, pkgs, ... }:

{
  home.file.".npmrc".source = ./config/npmrc;
}
