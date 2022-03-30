{ pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.xanderio = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "docker" "adbusers" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };
  #home-manager.users.xanderio = import /home/xanderio/Projects/nix-dotfiles/home.nix;
}
