{ pkgs, inputs, ... }: {
  config = {
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

    services.nginx = {
      enable = true;
      virtualHosts."hass.xanderio.de" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:8123";
          proxyWebsockets = true;
        };
      };
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
        "wled"
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
            trusted_proxies = [ "127.0.0.1" "::1" ];
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
  };
}
