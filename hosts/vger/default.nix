{ pkgs, lib, nixos-hardware, homeImports, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/laptop
    nixos-hardware.nixosModules.lenovo-thinkpad-t480s
    { home-manager.users.xanderio.imports = homeImports."xanderio@vger"; }
  ];

  home-manager.users.xanderio.home.stateVersion = "22.11";
  deployment.targetHost = null;

  networking.hostName = "vger";
  networking.firewall.allowedTCPPorts = [ 8080 ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    vaapiIntel
    libvdpau-va-gl
    vaapiVdpau
    intel-ocl
  ];
  environment.etc."openal/alsoft.conf".source = pkgs.writeText "alsoft.conf" "drivers=pulse";
  environment.variables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
  programs.gamemode.enable = true;

  systemd.services.lenovo_fix.wantedBy = lib.mkForce [ ];

  home-manager.users.xanderio.xanderio = {
    git = {
      enable = true;
      gpgFormat = "ssh";
      signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDvsq3ecdR4xigCpOQVfmWZYY74KnNJIJ5Fo0FsZMGW";
    };
    sway.scale = "1.1";
  };
}
