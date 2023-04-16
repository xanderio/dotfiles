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
            name = "zroot";
            start = "100MiB";
            end = "-8GiB";
            content = {
              type = "zfs";
              pool = "zroot";
            };
          }
          {
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
          type = "zfs_fs";
          options = {
            canmount = "off";
            mountpoint = "none";
          };
        };
        "nixos/root" = {
          type = "zfs_fs";
          mountpoint = "/";
        };
        "nixos/home" = {
          type = "zfs_fs";
          mountpoint = "/home";
        };
        "nixos/nix" = {
          type = "zfs_fs";
          mountpoint = "/nix";
        };
        "nixos/nix/store" = {
          type = "zfs_fs";
          mountpoint = "/nix/store";
        };
        "nixos/var" = {
          type = "zfs_fs";
          options.mountpoint = "none";
        };
        "nixos/var/lib" = {
          type = "zfs_fs";
          mountpoint = "/var/lib";
        };
        "nixos/var/log" = {
          type = "zfs_fs";
          mountpoint = "/var/log";
        };
      };
    };
  };
}
