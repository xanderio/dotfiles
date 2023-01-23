{config, ...}:
{
  services.thermald.enable = true;
  services.tlp = {
    settings = {
      USB_DENYLIST = let 
        devices = {
          "Unifying Receiver" = "046d:c52b";
          "Yamaha AG03MK2" = "0499:1756";
          "Keychron K1" = "05ac:024f";
        };
      in builtins.concatStringsSep " " (builtins.attrValues devices);
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };
}
