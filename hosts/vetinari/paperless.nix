{ pkgs, ... }: {
  services = {
    paperless = {
      enable = true;
      package = pkgs.paperless-ngx;
      address = "[::]";
      extraConfig = {
        PAPERLESS_URL="https://paper.xanderio.de";
        PAPERLESS_OCR_LANGUAGE = "deu";
      };
    };
  };
}
