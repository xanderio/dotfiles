{pkgs, config, ...}:
{
  age.secrets = {
    spotify-username = {
      file = ../../secrets/spotify-username.age;
      owner = "xanderio";
    };
    spotify-password = {
      file = ../../secrets/spotify-password.age;
      owner = "xanderio";
    };
  };
  users.users.xanderio = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "docker" "podman" "dialout" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDvsq3ecdR4xigCpOQVfmWZYY74KnNJIJ5Fo0FsZMGW" # vger
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBWdll21KPn3xuWFM+TnzdSRABU+0zVHi3nmCAzt/1QR" # hercules
    ];
  };
  home-manager.users.xanderio.services.spotifyd = {
    enable = true;
    settings.global = {
      username_cmd = "cat ${config.age.secrets.spotify-username.path}";
      password_cmd = "cat ${config.age.secrets.spotify-password.path}";

      bitrate = 320;
      backend = "pulseaudio";
      # volume_controller = "alsa";

      device_name = "vetinari";
      device_type = "speaker";

      autoplay = true;
    };
  };
}
