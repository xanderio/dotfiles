{ disks ? [ "/dev/vdb" ], ... }: {
  disk = {
    main = {
      device = builtins.elemAt disks 0;
      type = "disk";
      content = {
        type = "table";
        format = "gpt";
        partitions = [
          {
            type = "partition";
            name = "ESP";
            start = "1MiB";
            end = "100MiB";
            bootable = true;
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          }
          {
            type = "partition";
            name = "zroot";
            start = "100MiB";
            end = "-8GiB";
            content = {
              type = "zfs";
              pool = "zroot";
            };
          }
          {
            type = "partition";
            name = "swap";
            start = "-8GiB";
            end = "100%";
            content = {
              type = "swap";
              randomEncryption = true;
            };
          }
        ];
      };
    };
  };
  zpool = {
    zroot = {
      type = "zpool";
      mode = "";
      options = {
        ashift = "9";
        autotrim = "on";
      };
      rootFsOptions = {
        acltype = "posixacl";
        canmount = "off";
        compression = "zstd";
        dnodesize = "auto";
        normalization = "formD";
        relatime = "on";
        xattr = "sa";
      };

      datasets = {
        nixos = {
          zfs_type = "filesystem";
          options = {
            canmount = "off";
            mountpoint = "none";
          };
        };
        "nixos/root" = {
          zfs_type = "filesystem";
          mountpoint = "/";
        };
        "nixos/home" = {
          zfs_type = "filesystem";
          mountpoint = "/home";
        };
        "nixos/nix" = {
          zfs_type = "filesystem";
          mountpoint = "/nix";
        };
        "nixos/nix/store" = {
          zfs_type = "filesystem";
          mountpoint = "/nix/store";
        };
        "nixos/var" = {
          zfs_type = "filesystem";
          options.mountpoint = "none";
        };
        "nixos/var/lib" = {
          zfs_type = "filesystem";
          mountpoint = "/var/lib";
        };
        "nixos/var/log" = {
          zfs_type = "filesystem";
          mountpoint = "/var/log";
        };
      };
    };
  };
}
