{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  user = "pixelfed";
  group = "pixelfed";

  dataDir = "/mnt/pixelfed";

  pixelfed = pkgs.pixelfed.override {
    inherit dataDir;
  };

  php = pkgs.php.buildEnv {
    extensions = {
      enabled,
      all,
    }:
      enabled
      ++ (with all; [
        pdo_pgsql
        pgsql
        bcmath
        ctype
        curl
        exif
        gd
        iconv
        imagick
        intl
        # json
        mbstring
        openssl
        redis
        tokenizer
        # xml
        zip
      ]);
  };

  cfg = {
    APP_KEY._secret = "/var/pixelfed-key";

    APP_URL = "https://bitflip.jetzt";
    APP_DOMAIN = "bitflip.jetzt";
    ADMIN_DOMAIN = "bitflip.jetzt";
    SESSION_DOMAIN = "bitflip.jetzt";

    DB_CONNECTION = "pgsql";
    DB_HOST = "localhost";
    DB_DATABASE = "pixelfed";
    DB_USERNAME = "pixelfed";
    DB_PASSWORD = "pixelfed";

    REDIS_SCHEME = "unix";
    REDIS_PATH = config.services.redis.servers.pixelfed.unixSocket;
    REDIS_HOST = "null";
    REDIS_PORT = "null";

    MAIL_DRIVER = "smtp";
    MAIL_FROM_NAME = "Pixelfed";
    MAIL_FROM = "pixelfed@bitflip.jetzt";
    MAIL_HOST = "smtp.mailbox.org";
    MAIL_PORT = 587;
    MAIL_USERNAME = "alex@xanderio.de";
    MAIL_PASSWORD._secret = "/var/pixelfed-mail";
    MAIL_ENCRYPTION = "tls";

    LOG_CHANNEL = "daily";

    #DB_PASSWORD._secret = db.passwordFile;

    #APP_SERVICES_CACHE = "/run/pixelfed/cache/services.php";
    #APP_PACKAGES_CACHE = "/run/pixelfed/cache/packages.php";
    #APP_CONFIG_CACHE = "/run/pixelfed/cache/config.php";
    #APP_ROUTES_CACHE = "/run/pixelfed/cache/routes-v7.php";
    #APP_EVENTS_CACHE = "/run/pixelfed/cache/events.php";
    #APP_STORAGE_PATH = dataDir;

    SESSION_SECURE_COOKIE = true;

    IMAGE_DRIVER = "imagick";

    OPEN_REGISTRATION = false;

    ACTIVITY_PUB = true;
    AP_REMOTE_FOLLOW = true;

    OAUTH_ENABLED = true;

    IMPORT_INSTAGRAM = true;
    STORIES_ENABLED = true;

    ENABLE_CONFIG_CACHE = true;
    QUEUE_DRIVER = "redis";
    BROADCAST_DRIVER = "redis";
    CUSTOM_EMOJI = true;
  };

  # shell script for local administration
  artisan = pkgs.writeScriptBin "pixelfed" ''
    #! ${pkgs.runtimeShell}
    cd ${pixelfed}
    sudo=exec
    if [[ "$USER" != ${user} ]]; then
      sudo='exec /run/wrappers/bin/sudo -u ${user}'
    fi
    $sudo ${php}/bin/php artisan $*
  '';
in {
  environment.systemPackages = with pkgs; [artisan];

  services.postgresql = {
    enable = true;
    ensureDatabases = ["pixelfed"];
    ensureUsers = [
      {
        name = "pixelfed";
        ensurePermissions = {"DATABASE pixelfed" = "ALL PRIVILEGES";};
      }
    ];
  };

  services.redis.servers.pixelfed = {
    enable = true;
    user = user;
    unixSocketPerm = 770;
  };

  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    virtualHosts."bitflip.jetzt" = {
      forceSSL = true;
      enableACME = true;
      root = "${pixelfed}/public";
      locations = {
        "/" = {
          index = "index.php";
          tryFiles = "$uri $uri/ /index.php?$query_string";
        };

        "/favicon.ico".extraConfig = "access_log off; log_not_found off;";
        "/robots.txt".extraConfig = "access_log off; log_not_found off;";

        "~ \.php$".extraConfig = ''
          fastcgi_split_path_info ^(.+\.php)(/.+)$;
          fastcgi_pass unix:${config.services.phpfpm.pools."pixelfed".socket};
          fastcgi_index index.php;
          include ${pkgs.nginx}/conf/fastcgi.conf;
          fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name; # or $request_filename
        '';

        "/storage/" = {
          alias = "${dataDir}/storage/app/public/";
        };
      };
      extraConfig = ''
        add_header X-Frame-Options "SAMEORIGIN";
        add_header X-XSS-Protection "1; mode=block";
        add_header X-Content-Type-Options "nosniff";
        index index.html index.htm index.php;
        charset utf-8;
        client_max_body_size 15M;
        error_page 404 /index.php;
      '';
    };
  };

  services.phpfpm.pools.pixelfed = {
    inherit user group;
    phpPackage = php;
    phpOptions = ''
      log_error = on
      post_max_size = 200M
      upload_max_filesize = 200M
      max_execution_time = 600
    '';
    settings = {
      "listen.mode" = "0660";
      "listen.owner" = user;
      "listen.group" = group;
      "pm" = "dynamic";
      "pm.max_children" = 32;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 2;
      "pm.max_spare_servers" = 4;
      "pm.max_requests" = 500;
    };
  };

  systemd.services = rec {
    pixelfed-setup = {
      description = "Preperation tasks for pixelfed";
      before = ["phpfpm-pixelfed.service" "nginx.service"];
      after = ["postgresql.service"];
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        User = user;
        WorkingDirectory = "${pixelfed}/";
        RuntimeDirectoryMode = 0700;
      };
      path = [pkgs.replace-secret];
      script = let
        isSecret = v: isAttrs v && v ? _secret && isString v._secret;
        pixelfedEnvVars = lib.generators.toKeyValue {
          mkKeyValue = lib.flip lib.generators.mkKeyValueDefault "=" {
            mkValueString = v:
              with builtins;
                if isInt v
                then toString v
                else if isString v
                then v
                else if true == v
                then "true"
                else if false == v
                then "false"
                else if isSecret v
                then hashString "sha256" v._secret
                else throw "unsupported type ${typeOf v}: ${(lib.generators.toPretty {}) v}";
          };
        };
        secretPaths = lib.mapAttrsToList (_: v: v._secret) (lib.filterAttrs (_: isSecret) cfg);
        mkSecretReplacement = file: ''
          replace-secret ${escapeShellArgs [(builtins.hashString "sha256" file) file "${dataDir}/.env"]}
        '';
        secretReplacements = lib.concatMapStrings mkSecretReplacement secretPaths;
        filteredConfig = lib.converge (lib.filterAttrsRecursive (_: v: ! elem v [{} null])) cfg;
        pixelfedEnv = pkgs.writeText "pixelfed.env" (pixelfedEnvVars filteredConfig);
      in ''
        # error handling
        set -euo pipefail
        # set permissions
        umask 077

        if [ -e ${dataDir}/bootstrap/app.php ]; then
          rm ${dataDir}/bootstrap/app.php
        fi
        ln -s ${pixelfed}/bootstrap_dist/app.php ${dataDir}/bootstrap/app.php

        if [ -e ${dataDir}/storage/app/cities.json ]; then
          rm ${dataDir}/storage/app/cities.json
        fi
        ln -s ${pixelfed}/storage_dist/app/cities.json ${dataDir}/storage/app/cities.json

        for path in avatars emoji headers textimg; do
            for p in ${pixelfed}/storage_dist/app/public/$path/*; do
              if [ -e ${dataDir}/storage/app/public/$path/$(basename $p) ]; then
                rm ${dataDir}/storage/app/public/$path/$(basename $p)
              fi
              ln -s $p ${dataDir}/storage/app/public/$path
            done
        done

        # create .env file
        install -T -m 0600 -o ${user} ${pixelfedEnv} "${dataDir}/.env"
        ${secretReplacements}
        if ! grep 'APP_KEY=base64:' "${dataDir}/.env" >/dev/null; then
            sed -i 's/APP_KEY=/APP_KEY=base64:/' "${dataDir}/.env"
        fi

        # update route cache
        ${php}/bin/php artisan config:cache
        ${php}/bin/php artisan route:cache
        ${php}/bin/php artisan view:cache

        # migrate db
        ${php}/bin/php artisan migrate --force

        ${php}/bin/php artisan import:cities
        ${php}/bin/php artisan instance:actor
      '';
    };

    pixelfed-horizon = {
      wantedBy = ["multi-user.target"];
      after = ["network.target"];
      requires = ["phpfpm-pixelfed.service" "postgresql.service" "redis-pixelfed.service" "nginx.service" "pixelfed-setup.service"];
      serviceConfig = {
        Type = "simple";
        User = user;
        WorkingDirectory = "${pixelfed}/";
        Restart = "on-failure";
        ExecStart = "${php}/bin/php artisan horizon";
      };
    };

    pixelfed-schedule = {
      serviceConfig = {
        Type = "oneshot";
        User = user;
        WorkingDirectory = "${pixelfed}/";
        ExecStart = "${php}/bin/php artisan schedule:run";
      };
    };
    pixelfed-cache-clean = {
      serviceConfig = {
        Type = "oneshot";
        User = user;
        WorkingDirectory = "${pixelfed}/";
        ExecStart = "${php}/bin/php artisan cache:clear";
      };
    };
  };
  systemd.timers = {
    pixelfed-schedule = {
      wantedBy = ["timers.target"];
      after = ["network.target"];
      requires = ["phpfpm-pixelfed.service" "postgresql.service" "redis-pixelfed.service" "nginx.service" "pixelfed-setup.service"];
      timerConfig.OnBootSec = "1m";
      timerConfig.OnUnitActiveSec = "1m";
      timerConfig.Unit = "pixelfed-schedule.service";
    };
    pixelfed-cache-clean = {
      wantedBy = ["timers.target"];
      after = ["network.target"];
      requires = ["phpfpm-pixelfed.service" "postgresql.service" "redis-pixelfed.service" "nginx.service" "pixelfed-setup.service"];
      timerConfig.OnBootSec = "1m";
      timerConfig.OnUnitActiveSec = "1m";
      timerConfig.Unit = "pixelfed-cache-clean.service";
    };
  };
  systemd.tmpfiles.rules = [
    "d /run/pixelfed                         0710 ${user} ${group} - -"
    "d /run/pixelfed/cache                   0710 ${user} ${group} - -"
    "d ${dataDir}                            0710 ${user} ${group} - -"
    "d ${dataDir}/bootstrap                  0710 ${user} ${group} - -"
    "d ${dataDir}/bootstrap/cache            0710 ${user} ${group} - -"
    "d ${dataDir}/storage                    0710 ${user} ${group} - -"
    "d ${dataDir}/storage/app                0710 ${user} ${group} - -"
    "d ${dataDir}/storage/app/public         0710 ${user} ${group} - -"
    "d ${dataDir}/storage/app/remcache       0700 ${user} ${group} - -"
    "d ${dataDir}/storage/purify             0700 ${user} ${group} - -"
    "d ${dataDir}/storage/framework          0700 ${user} ${group} - -"
    "d ${dataDir}/storage/framework/cache    0700 ${user} ${group} - -"
    "d ${dataDir}/storage/framework/sessions 0700 ${user} ${group} - -"
    "d ${dataDir}/storage/framework/views    0700 ${user} ${group} - -"
    "d ${dataDir}/storage/logs               0700 ${user} ${group} - -"
  ];

  users.users.${user} = {
    isSystemUser = true;
    group = group;
    home = dataDir;
    packages = with pkgs; [ffmpeg pngquant optipng jpegoptim gd php];
  };

  users.groups.${group}.members = [user config.services.nginx.user];
}
