{
  config = {
    virtualisation.oci-containers.containers.tdarr = {
      image = "ghcr.io/haveagitgat/tdarr";
      ports = [
        "4213:8265"
        "4214:8266"
      ];
      autoStart = true;
      environment = {
        PUID = "1000";
        PGID = "100";
        serverIP = "0.0.0.0";
        serverPort = "8266";
        webUIPort = "8265";
        internalNode = "true";
        inContainer = "true";
        ffmpegVersion = "7";
        nodeName = "drumknott";
        TZ = "Europa/Berlin";
      };
      volumes = [
        "/var/lib/tdarr/data/configs:/app/configs"
        "/var/lib/tdarr/data/logs:/app/logs"
        "/var/lib/tdarr/data/server:/app/server"
        "/var/lib/tdarr/data/cache:/temp"
        "/tank:/tank"
      ];
      extraOptions = [
        "--device=/dev/dri:/dev/dri"
      ];
    };
  };
}
