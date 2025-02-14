{ lib, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      ssh = "TERM=xterm-256color command ssh";
      cat = "${lib.getExe pkgs.bat}";
    };

    shellAbbrs = {
      g = "git";
      s = "git s";
      d = "git diff";
      ds = "git diff --cached";
      sl = "git sl";
      "dotdot" = {
        regex = "^\\.\\.+$";
        function = "multicd";
      };
      "!!" = {
        position = "anywhere";
        function = "last_history_item";
      };
    };

    interactiveShellInit = ''
      nix-your-shell fish | source
    '';

    shellInit = ''
      fish_config theme choose "Catppuccin Mocha"
      set fish_cursor_unknown block
      # nix
      set fish_function_path ${pkgs.fishPlugins.foreign-env}/share/fish/vendor_functions.d $fish_function_path
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
          fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      end

      if test -e $HOME/.iterm2_shell_integration.fish 
        source $HOME/.iterm2_shell_integration.fish
      end

      # setup 1password plugins
      if test -e $HOME/.config/op/plugins.sh 
        source $HOME/.config/op/plugins.sh
      end

      if test -e /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
      end

    '';

    # loginShellInit = ''
    #   ssh-add
    # '';

    functions =
      {
        fish_greeting.body = "";
        sops = {
          description = "sops wrapper to extract age key from 1password";
          body = ''
            if string match -q -- "op://*" $SOPS_AGE_KEY
              op run --no-masking -- sops $argv
            else
              command sops $argv
            end
          '';
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
          body = " ${pkgs.curl}/bin/curl -vk 'https://10.101.64.10/en/' -H 'Host: wifi.bahn.de' -H 'Cookie: csrf=asdf' --data 'login=true&CSRFToken=asdf'";
        };
        multicd = {
          description = "This expands .. to cd ../, ... to cd ../../ and .... to cd ../../../ and so on.";
          body = "echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)";
        };
        last_history_item = {
          body = "echo $history[1]";
        };
      }
      // (lib.optionalAttrs pkgs.stdenv.isLinux {
        vcam = {
          description = "gphoto2 based virtual webcam";
          body =
            let
              gphoto2 = "${pkgs.gphoto2}/bin/gphoto2";
              ffmpeg = "${pkgs.ffmpeg_6-full}/bin/ffmpeg";
            in
            ''
              ${gphoto2} --stdout --capture-movie | ${ffmpeg} -hwaccel vaapi -c:v mjpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 2 -f v4l2 /dev/video0
            '';
        };
      });
    plugins = [
      # {
      #   name = "fish-ssh-agent";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "danhper";
      #     repo = "fish-ssh-agent";
      #     rev = "fd70a2afdd03caf9bf609746bf6b993b9e83be57";
      #     sha256 = "e94Sd1GSUAxwLVVo5yR6msq0jZLOn2m+JZJ6mvwQdLs=";
      #   };
      # }
    ];
  };

  xdg.configFile."fish/themes/Catppuccin Mocha.theme".text = # fish
    ''
      # name: 'Catppuccin Mocha'
      # url: 'https://github.com/catppuccin/fish'
      # preferred_background: 1e1e2e

      fish_color_normal cdd6f4
      fish_color_command 89b4fa
      fish_color_param f2cdcd
      fish_color_keyword f38ba8
      fish_color_quote a6e3a1
      fish_color_redirection f5c2e7
      fish_color_end fab387
      fish_color_comment 7f849c
      fish_color_error f38ba8
      fish_color_gray 6c7086
      fish_color_selection --background=313244
      fish_color_search_match --background=313244
      fish_color_option a6e3a1
      fish_color_operator f5c2e7
      fish_color_escape eba0ac
      fish_color_autosuggestion 6c7086
      fish_color_cancel f38ba8
      fish_color_cwd f9e2af
      fish_color_user 94e2d5
      fish_color_host 89b4fa
      fish_color_host_remote a6e3a1
      fish_color_status f38ba8
      fish_pager_color_progress 6c7086
      fish_pager_color_prefix f5c2e7
      fish_pager_color_completion cdd6f4
      fish_pager_color_description 6c7086
    '';
}
