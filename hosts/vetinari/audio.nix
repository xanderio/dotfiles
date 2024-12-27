{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    ipv4 = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
      workstation = true;
    };
  };
}
