{
  services.librenms = {
    enable = true;
    hostname = "nms.internal";
    database = {
      createLocally = true;
      socket = "/run/mysqld/mysqld.sock";
    };
    settings = {

      enable_billing = true;

      discovery_by_ip = true;
      nets = [
        "10.215.10.0/24"
        "10.216.10.0/24"
        "10.255.255.0/24"
      ];

      snmp.version = [ "v2c" ];
    };
    environmentFile = "";
    nginx = {

    };
    phpOptions = {
      # https://docs.librenms.org/Support/Performance/#for-web-servers-using-mod_php-and-php-fpm
      "opcache.enable" = 1;
      "opcache.memory_consumption" = 256;
    };
    # https://docs.librenms.org/Support/Performance/#optimise-poller-wrapper
    # pollerThreads = config.microvm.vcpu * 2;
  };
}
