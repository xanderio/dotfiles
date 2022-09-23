{ pkgs
, config
, ...
}: {
  imports = [
    ./server.nix
    ./agent.nix
  ];
  age.secrets.woodpecker.file = ../../secrets/woodpecker.age;
}
