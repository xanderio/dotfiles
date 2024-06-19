{ lib, config, ... }:

with lib;

let
  cfg = config.services.authentik-proxy;
  mkVirtualHosts = _: {
    extraConfig = ''
      # Increase buffer size for large headers
      # This is needed only if you get 'upstream sent too big header while reading response
      # header from upstream' error when trying to access an application protected by goauthentik
      proxy_buffers 8 16k;
      proxy_buffer_size 32k;
    '';
    locations."/".extraConfig = ''
      ##############################
      # authentik-specific config
      ##############################
      auth_request     /outpost.goauthentik.io/auth/nginx;
      error_page       401 = @goauthentik_proxy_signin;
      auth_request_set $auth_cookie $upstream_http_set_cookie;
      add_header       Set-Cookie $auth_cookie;

      # translate headers from the outposts back to the actual upstream
      auth_request_set $authentik_username $upstream_http_x_authentik_username;
      auth_request_set $authentik_groups $upstream_http_x_authentik_groups;
      auth_request_set $authentik_email $upstream_http_x_authentik_email;
      auth_request_set $authentik_name $upstream_http_x_authentik_name;
      auth_request_set $authentik_uid $upstream_http_x_authentik_uid;

      proxy_set_header X-authentik-username $authentik_username;
      proxy_set_header X-authentik-groups $authentik_groups;
      proxy_set_header X-authentik-email $authentik_email;
      proxy_set_header X-authentik-name $authentik_name;
      proxy_set_header X-authentik-uid $authentik_uid;
    '';

    # all requests to /outpost.goauthentik.io must be accessible without authentication
    locations."/outpost.goauthentik.io" = {
      recommendedProxySettings = false;
      extraConfig = ''
        proxy_pass              https://sso.xanderio.de/outpost.goauthentik.io;
        # ensure the host of this vserver matches your external URL you've configured
        # in authentik
        proxy_set_header        Host sso.xanderio.de;
        proxy_set_header        X-Original-URL $scheme://$http_host$request_uri;
        add_header              Set-Cookie $auth_cookie;
        auth_request_set        $auth_cookie $upstream_http_set_cookie;
        proxy_pass_request_body off;
        proxy_set_header        Content-Length "";
      '';
    };

    locations."@goauthentik_proxy_signin" = {
      recommendedProxySettings = false;
      extraConfig = ''
        internal;
        add_header Set-Cookie $auth_cookie;
        return 302 /outpost.goauthentik.io/start?rd=$request_uri;
      '';
    };
  };
in
{
  options.services.authentik-proxy = with lib; {
    enable = mkEnableOption "authentik-proxy";
    domains = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Domains with should be protected by authentik";
    };
  };
  config = lib.mkIf cfg.enable { services.nginx.virtualHosts = genAttrs cfg.domains mkVirtualHosts; };
}
