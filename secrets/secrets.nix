let
  xanderio = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDvsq3ecdR4xigCpOQVfmWZYY74KnNJIJ5Fo0FsZMGW";

  # servers 
  vger = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMRd7/EWeUvAqeFID1cgkgnQAeTWZDCmkQDWwd5lHNGT";
  delenn = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFlkC7H1NKn11pFzBJp2OSdnr+5AKwTLamwml4swCarT";
  valen = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICtwumo7Hw3P7L63i7ewipolOqP07n0vqlbXQHVX80nD";
  block = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIAzwiJ+akj5UtvvsYIjikBx6QJfyVPNGfn92eJR9mXH";
  vetinari = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH/AvKCMqzBG7lrietcQDy/Aqu7M+cGdUjeYv/qmfclv";

  servers = [ delenn valen block vetinari ];
in
{
  "storagebox-sshkey.age".publicKeys = [ xanderio ] ++ servers;
  "backup-key.age".publicKeys = [ xanderio ] ++ servers;

  "woodpecker.age".publicKeys = [ xanderio block ];
  "hercules-cache.age".publicKeys = [ xanderio block ];
  "hercules-token.age".publicKeys = [ xanderio block ];

  "graftify.age".publicKeys = [ xanderio valen ];

  "synapse-signing-key.age".publicKeys = [ xanderio delenn ];
  "synapse-registration_shared_secret.age".publicKeys = [ xanderio delenn ];

  "outline.age".publicKeys = [ xanderio valen ];
  "outline-bucket-secretKey.age".publicKeys = [ xanderio valen ];
  "outline-oidc-secretKey.age".publicKeys = [ xanderio valen ];

  "spotify-username.age".publicKeys = [ xanderio vetinari ];
  "spotify-password.age".publicKeys = [ xanderio vetinari ];
}
