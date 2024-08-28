{ pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      qemu
      libvirt
      virt-manager
    ];

    launchd.daemons.libvirt = {
      path = [
        pkgs.gcc
        pkgs.qemu
        pkgs.dnsmasq
        pkgs.libvirt
      ];
      serviceConfig = {
        KeepAlive = true;
        RunAtLoad = true;
        ProgramArguments = [
          "${pkgs.libvirt}/bin/libvirtd"
          "-f"
          "/etc/libvirt/libvirtd.conf"
          "-v"
          "-p"
          "/run/libvirt/libvirtd.pid"
        ];
        WorkingDirectory = "/var/lib/libvirt";
        StandardOutPath = "/var/log/libvirt/libvirt.log";
        StandardErrorPath = "/var/log/libvirt/libvirt-error.log";
      };
    };
    launchd.daemons.virtlogd = {
      serviceConfig = {
        KeepAlive = true;
        RunAtLoad = true;
        WorkingDirectory = "/var/lib/libvirt";
        ProgramArguments = [
          "${pkgs.libvirt}/bin/virtlogd"
          "-d"
          "-p"
          "/run/libvirt/virtlogd.pid"
        ];
        StandardOutPath = "/var/log/libvirt/virtlogd.log";
        StandardErrorPath = "/var/log/libvirt/virtlogd-error.log";
      };
    };
    environment.etc."libvirt/libvirtd.conf".text = ''
      mode = "direct"
      unix_sock_group = "staff"
      unix_sock_ro_perms = "0770"
      unix_sock_rw_perms = "0770"
      unix_sock_admin_perms = "0770"
      auth_unix_ro = "none"
      auth_unix_rw = "none"
      log_level = 3
      log_outputs="3:stderr"
    '';
    environment.etc."libvirt/qemu.conf".text = ''
      security_driver = "none"
      dynamic_ownership = 0
      remember_owner = 0
    '';
  };
}
