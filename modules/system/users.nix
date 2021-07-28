{ config, lib, pkgs, ... }:

let inherit (lib) mkOption types; in
{
  options =
    {
      users.primaryUser = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
    };
}
