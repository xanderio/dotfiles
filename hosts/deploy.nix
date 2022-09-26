inputs: {
  nodes = with inputs.deploy-rs.lib.x86_64-linux; {
    delenn = {
      hostname = "delenn.xanderio.de";
      profiles.system = {
        user = "root";
        path = activate.nixos inputs.self.nixosConfigurations.delenn;
      };
    };
    valen = {
      hostname = "valen.xanderio.de";
      profiles.system = {
        user = "root";
        path = activate.nixos inputs.self.nixosConfigurations.valen;
      };
    };
    block = {
      hostname = "block.xanderio.de";
      profiles.system = {
        user = "root";
        path = activate.nixos inputs.self.nixosConfigurations.block;
      };
    };
  };

  sshUser = "root";
}
