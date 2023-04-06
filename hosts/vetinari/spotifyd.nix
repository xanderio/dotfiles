{config, ...}:
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

      audio_format = "F32";
      volume_normalisation = true;
      normalisation_pregain = -10;
    };
  };
}
