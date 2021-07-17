{ config, pkgs, ... }:

{
  home.file.".sqitch/sqitch.conf".source = ./config/sqitch/config.ini;
}
