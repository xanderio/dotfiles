{ pkgs, config, lib, inputs, homeImports, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./spotifyd.nix
    ./audio.nix
    ./paperless.nix
    ./audiobookshelf.nix
    ./nextcloud.nix
    ./netatalk.nix
    ../../modules/server
    { home-manager.users.xanderio.imports = homeImports."server"; }
  ];

  deployment.targetHost = "vetinari.tail2f592.ts.net";
  home-manager.users.xanderio.home.stateVersion = "22.11";

  services.aria2.enable = true;
  services.aria2.extraArguments = "--rpc-listen-all --remote-time=true --rpc-secret=foobar";

  networking.hostName = "vetinari";
  networking.hostId = "8419e344";

  disko.devices = import ./disko.nix {
    disks = [ "/dev/sda" ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 2;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.supportedFilesystems = [ "zfs" ];

  boot.zfs.extraPools = [ "media" ];

  nixpkgs.config.packageOverrides = pkgs: {
    python311Packages = pkgs.python311Packages.overrideScope (final: prev: {
      gpiozero = inputs.nipxkgs-master.legacyPackages.x68_64-linux.python311Packages.gpiozero;
    });
  };

  networking.firewall = {
    allowedTCPPorts = [
      #homekit
      21063
    ];
    allowedUDPPorts = [
      5353
    ];
  };

  # remove after home-assistant-chip-core has upgrade to openssl 3 
  # https://github.com/project-chip/connectedhomeip/issues/25688
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  services.home-assistant = {
    enable = true;

    extraPackages = p: with p; [
      aiogithubapi
      (p.buildPythonPackage rec {
        pname = "aioairctrl";
        version = "0.2.4";

        src = p.fetchPypi {
          inherit pname version;
          hash = "sha256-BIJWwMQq3QQjhyO0TSw+C6muyr3Oyv6UHr/Y3iYqRUM=";
        };

        buildInputs = [ setuptools ];

        propagatedBuildInputs = [ pycryptodomex aiocoap ];

        pythonImportsCheck = [
          "aioairctrl"
        ];
      })
    ];

    extraComponents = [
      "default_config"
      "met"
      "esphome"
      "backup"
      "zha"
      "fritz"
      "mqtt"
      "spotify"
      "homekit"
      "switch_as_x"
    ];

    config =
      {
        default_config = { };

        group = "!include groups.yaml";
        automation = "!include automations.yaml";
        scene = "!include scenes.yaml";
        script = "!include scripts.yaml";

        http = {
          use_x_forwarded_for = true;
          trusted_proxies = [ "100.64.0.0/10" "fd7a:115c:a1e0::/48" ];
        };

        zha.custom_quirks_path =
          pkgs.fetchFromGitHub
            {
              owner = "jacekk015";
              repo = "zha_quirks";
              rev = "d539cd1df2ea58d8438080f58b011ffe82f114d1";
              hash = "sha256-ZLaaJOJ6rkCgjhsZISnBH98DMwexrpU12XmcJJbytXk=";
            };

      };
  };

  services.mosquitto = {
    enable = true;
    listeners = [
      {
        acl = [ "pattern readwrite #" ];
        omitPasswordAuth = true;
        settings.allow_anonymous = true;
      }
    ];
  };

  services.jellyfin.enable = true;

  services.syncthing = {
    enable = true;
    relay.enable = true;
    openDefaultPorts = true;
    settings = {
      options = {
        urAccepted = -1;
        localAnnounceEnabled = true;
      };
    };
    overrideDevices = false;
    overrideFolders = false;
  };

  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    vaapiIntel
    libvdpau-va-gl
    vaapiVdpau
    intel-ocl
  ];

  system.stateVersion = lib.mkForce "23.05";
}
