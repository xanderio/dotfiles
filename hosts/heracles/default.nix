{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../configuration/laptop
  ];

  home-manager.users.xanderio.xanderio = {
    git = {
      enable = true;
      email = "alexander.sieg@binary.butterfly.de";
      signingKey = "0x3ABD985B2004F8E6";
      gpgFormat = "gpg";
    };
  };
}