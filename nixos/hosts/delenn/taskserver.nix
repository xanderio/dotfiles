{ pkgs
, config
, ...
}: {
  services.taskserver = {
    enable = true;
    fqdn = "${config.networking.hostName}.${config.networking.domain}";
    listenHost = "::";
    organisations.default.users = [ "xanderio" "nina" ];
  };
}
