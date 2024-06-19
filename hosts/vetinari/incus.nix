{...}: {
  config = {
    users.users.xanderio.extraGroups = ["incus-admin"];
    virtualisation.incus = {
      enable = true;
      ui.enable = true;
    };
  };
}
