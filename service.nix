{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.chains;
  fractalide = import <fractalide> {};
  buffet = fractalide.buffet;
  fractal = import ./default.nix { inherit buffet; fractalide = null; };
  serviceSubgraph = buffet.support.subgraph {
    src = ./.;
    name = "chains_service";
    flowscript = with buffet.edges; with buffet.nodes; ''
      '${net_http_edges.net_http_address}:(address="${cfg.bindAddress}:${toString cfg.port}")' -> listen chains(${fractal.nodes.chains})
      '${fs_path}:(path="${cfg.dataDir}/${cfg.dbName}")' -> db_path chains()
    '';
  };
  fvm = import (<fractalide> + "/support/fvm/") { inherit buffet; };
in
{
  options.services.chains = {
    enable = mkEnableOption "Fractalchains Example";
    package = mkOption {
      default = serviceSubgraph;
      defaultText = "fractalComponents.chains";
      type = types.package;
      description = ''
        Fractalchains example.
      '';
    };
    user = mkOption {
      type = types.str;
      default = "chains";
      description = "User account under which chains runs.";
    };
    bindAddress = mkOption {
      type = types.string;
      default = "127.0.0.1";
      description = ''
        Defines the IP address by which chains will be accessible.
      '';
    };
    port = mkOption {
      type = types.int;
      default = 8080;
      description = ''
        Defined the port number to listen.
      '';
    };
    dbName = mkOption {
      type = types.str;
      default = "todos.db";
      description = "the database file name.";
    };
    dataDir = mkOption {
      type = types.path;
      default = "/var/fractalide/chains";
      description = "The DB will be written to this directory, with the filename specified using the 'dbName' configuration.";
    };
    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to open ports in the firewall for the server.
      '';
    };
  };
  config = mkIf cfg.enable {
    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = [ cfg.port ];
    };
    users.extraUsers.chains = {
      name = cfg.user;
      uid = config.ids.uids.chains;
      description = "Fractalchains database user";
    };
    systemd.services.chains_init = {
      description = "Fractalchains Server Initialisation";
      wantedBy = [ "chains.service" ];
      before = [ "chains.service" ];
      serviceConfig.Type = "oneshot";
      script = ''
        if ! test -e ${cfg.dataDir}/${cfg.dbName}; then
          mkdir -m 0700 -p ${cfg.dataDir}
          ${pkgs.sqlite.bin}/bin/sqlite3 ${cfg.dataDir}/${cfg.dbName} 'CREATE TABLE `todos` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `ip` BLOB)'
          chown -R ${cfg.user} ${cfg.dataDir}
        fi
      '';
    };
    systemd.services.chains = {
      description = "Fractalchains example";
      path = [ cfg.package ];
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        PermissionsStartOnly = true;
        Restart = "always";
        ExecStart = "${fvm}/bin/fvm ${cfg.package}";
        User = cfg.user;
      };
    };
    environment.systemPackages = [ fvm cfg.package ];
  };
}
