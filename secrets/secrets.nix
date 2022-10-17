let
  xanderio = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDvsq3ecdR4xigCpOQVfmWZYY74KnNJIJ5Fo0FsZMGW";

  # servers 
  vger = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMRd7/EWeUvAqeFID1cgkgnQAeTWZDCmkQDWwd5lHNGT";
  delenn = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFlkC7H1NKn11pFzBJp2OSdnr+5AKwTLamwml4swCarT";
  valen = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICtwumo7Hw3P7L63i7ewipolOqP07n0vqlbXQHVX80nD";
  block = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIAzwiJ+akj5UtvvsYIjikBx6QJfyVPNGfn92eJR9mXH";

  servers = [ delenn valen block ];
in
{
  "storagebox-sshkey.age".publicKeys = [ xanderio ] ++ servers;
  "backup-key.age".publicKeys = [ xanderio ] ++ servers;

  "woodpecker.age".publicKeys = [ xanderio block ];
  "hercules-cache.age".publicKeys = [ xanderio block ];
  "hercules-token.age".publicKeys = [ xanderio block ];

  "graftify.age".publicKeys = [ xanderio valen ];
}
