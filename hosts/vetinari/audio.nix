{ pkgs, ... }:
{
  services.pipewire = {
    enable = true;
    systemWide = true;
    socketActivation = false;
    pulse.enable = true;
    alsa.enable = true;
  };

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

  users.users.xanderio.extraGroups = [ "pipewire" ];
}
