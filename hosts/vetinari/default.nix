{ pkgs, config, lib, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./spotifyd.nix
    ./audio.nix
    ./minecraft.nix
    ./paperless.nix
    ./nextcloud.nix
    ./netatalk.nix
  ];

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
    ];

    config = {
      default_config = { };

      group = "!include groups.yaml";
      automation = "!include automations.yaml";
      scene = "!include scenes.yaml";
      script = "!include scripts.yaml";

      http = {
        use_x_forwarded_for = true;
        trusted_proxies = [ "100.64.0.0/10" "fd7a:115c:a1e0::/48" ];
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
