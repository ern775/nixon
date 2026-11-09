{ ... }: {
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  networking.firewall.interfaces."wlo1".allowedUDPPorts = [ 67 ];

  environment.etc."NetworkManager/dnsmasq-shared.d/hotspot-dns.conf".text = ''
    dhcp-option=6,1.1.1.1,1.0.0.1
  '';
}
