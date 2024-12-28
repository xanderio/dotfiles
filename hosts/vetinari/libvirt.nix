{
  config = {
    virtualisation.libvirtd.enable = true;
    security.polkit.enable = true;
    users.users.xanderio.extraGroups = [ "libvirtd" ];
  };
}
