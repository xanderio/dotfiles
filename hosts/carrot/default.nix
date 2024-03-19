{ config, lib, pkgs, ... }: {
  imports = [
    ../../modules/server
    ../../profiles/hetzner_vm

    ./miniflux.nix
    ./ntfy.nix
    ./website.nix
    ./authentik.nix
    ./postgresql.nix
    ./matrix.nix

    ./disko-config.nix
  ];
  networking.hostName = "carrot";

  deployment.targetHost = "carrot.xanderio.de";
  systemd.network.networks."10-uplink".networkConfig.Address = "2a01:4f9:c010:ef51::1/64";

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.journald.extraConfig = ''
    SystemMaxUse = 1G
  '';

  x.sops.secrets = {
    "hosts/carrot/backup/repo_key".owner = "root";
  };
  programs.ssh.knownHosts = {
    "j11x0ojk.repo.borgbase.com" = {
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMS3185JdDy7ffnr0nLWqVy8FaAQeVh1QYUSiNpW5ESq";
    };
  };
  services.borgbackup.jobs = {
    borgbase = {
      paths = [ "/var/lib" "/home" "/root" ];
      exclude = [ "'**/.cache'" "/var/lib/postgresql/" ];
      repo = "ssh://j11x0ojk@j11x0ojk.repo.borgbase.com/./repo::root";
      encryption = {
        mode = "repokey-blake2";
        passCommand = "cat ${config.sops.secrets."all/borg_backup/repo_key".path}";
      };
      environment = {
        BORG_RSH = "ssh -i /etc/ssh/ssh_host_ed25519_key";
      };
      compression = "auto,zstd,10";
      prune.keep = {
        within = "1d"; # Keep all archives from the last day
        daily = 7;
        weekly = 4;
        monthly = 1;
      };
      extraCreateArgs = "--verbose --exclude-caches --stats --checkpoint-interval 600";
      startAt = "hourly";
    };
  } // (lib.listToAttrs (map
    (name:
      lib.nameValuePair "psql-${name}" {
        dumpCommand = pkgs.writeShellScript "psql-backup-${name}"
          "${pkgs.sudo}/bin/sudo -u postgres ${config.services.postgresql.package}/bin/pg_dump -Cc -d ${name}";
        repo = "ssh://j11x0ojk@j11x0ojk.repo.borgbase.com/./repo::psql";
        encryption = {
          mode = "repokey-blake2";
          passCommand = "cat ${config.sops.secrets."all/borg_backup/repo_key".path}";
        };
        environment = {
          BORG_RSH = "ssh -i /etc/ssh/ssh_host_ed25519_key";
        };
        compression = "auto,zstd,10";
        prune.keep = {
          within = "1d"; # Keep all archives from the last day
          daily = 7;
          weekly = 4;
          monthly = 1;
        };
        extraCreateArgs = "--verbose --exclude-caches --stats --checkpoint-interval 600";
        startAt = "hourly";
      }
    )
    (config.services.postgresql.ensureDatabases ++ [ "matrix-synapse" ])))
  ;
}
