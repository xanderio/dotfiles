{inputs, pkgs, ...}:{
  home.packages = [
    pkgs.ntfy-sh
  ];
  xdg.configFile."ntfy/client.yml".text = ''
    default-host: https://ntfy.xanderio.de
  '';
}
