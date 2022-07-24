{ pkgs, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.xanderio = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "docker" "podman" "dialout" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDvsq3ecdR4xigCpOQVfmWZYY74KnNJIJ5Fo0FsZMGW" # vger
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBWdll21KPn3xuWFM+TnzdSRABU+0zVHi3nmCAzt/1QR" # hercules
    ];
  };
}
