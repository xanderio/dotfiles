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

    loginShellInit = ''
      ssh-add
    '';

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
      {
        name = "fish-ssh-agent";
        src = pkgs.fetchFromGitHub {
          owner = "danhper";
          repo = "fish-ssh-agent";
          rev = "fd70a2afdd03caf9bf609746bf6b993b9e83be57";
          sha256 = "e94Sd1GSUAxwLVVo5yR6msq0jZLOn2m+JZJ6mvwQdLs=";
        };
      }
    ];
  };
}
