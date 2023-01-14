{ inputs, self, ... }:
{
  flake.deploy = {
    nodes = with inputs.deploy-rs.lib.x86_64-linux; {
      delenn = {
        hostname = "delenn.xanderio.de";
        profiles.system = {
          user = "root";
          path = activate.nixos self.nixosConfigurations.delenn;
        };
      };
      valen = {
        hostname = "valen.xanderio.de";
        profiles.system = {
          user = "root";
          path = activate.nixos self.nixosConfigurations.valen;
        };
      };
      block = {
        hostname = "block.xanderio.de";
        profiles.system = {
          user = "root";
          path = activate.nixos self.nixosConfigurations.block;
        };
      };
      lobsang = {
        hostname = "lobsang.tail2f592.ts.net";
        profiles.system = {
          user = "root";
          path = activate.nixos self.nixosConfigurations.lobsang;
        };
      };
    };

    sshUser = "root";
  };
}
