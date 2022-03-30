{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      hm = "home-manager";
      ll = "ls -l";
      la = "ls -la";
      ssh = "TERM=xterm-256color command ssh";
    };
    shellInit = ''
      set fish_color_normal normal
      set fish_color_command cyan
      set fish_color_param white
      set fish_color_redirection green
      set fish_color_comment black
      set fish_color_error red
      set fish_color_escape red
      set fish_color_operator red
      set fish_color_end green
      set fish_color_quote yellow
      set fish_color_autosuggestion brblack
      set fish_color_valid_path --underline
      set fish_color_cwd white
      set fish_color_cwd_root white
      set fish_color_match white
      set fish_color_search_match --background=black
      set fish_color_selection --background=green
      set fish_pager_color_prefix white
      set fish_pager_color_completion white
      set fish_pager_color_description white
      set fish_pager_color_progress white
      set fish_color_history_current white

      set fish_cursor_unknown block
      #set -ax NIX_PATH $HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels
      # nix
      set fish_function_path ${pkgs.fishPlugins.foreign-env}/share/fish/vendor_functions.d $fish_function_path
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
          fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      end
      any-nix-shell fish | source
    '';

    functions = {
      fish_greeting = {
        body = "";
      };
      ls = {
        body = ''
          if type --quiet exa
            exa --group-directories-first --git $argv
          else
            command ls --color=auto $argv
          end'';
      };
      cat = {
        body = ''
          if type --quiet bat
            bat $argv
          else
            command cat $argv
          end'';
      };
      fish_title = {
        body = ''
          if [ $_ = fish ]
              echo (pwd)
          else
              echo (status current-command)
          end'';
      };
      woi_login = {
        description = "Wifi@DB / WifiOnICE login script";
        body = ''
          curl -vk 'https://10.101.64.10/en/' -H 'Host: wifi.bahn.de' -H 'Cookie: csrf=asdf' --data 'login=true&CSRFToken=asdf'
        '';
      };
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      command_timeout = 100;
      add_newline = false;
    };
  };
}
