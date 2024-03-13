{
  home-manager.users.xanderio.services.spotifyd = {
    enable = false;
    settings.global = {
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
