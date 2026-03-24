{ ... }:
{
  services = {
    pihole-ftl = {
      enable = true;
      openFirewallDNS = true;
      openFirewallDHCP = true;
      openFirewallWebserver = true;
      queryLogDeleter.enable = true;
      lists = [
        {
          url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
          type = "block";
          enabled = true;
          description = "Steven Black's HOSTS";
        }
        {
          url = "https://big.oisd.nl";
          type = "block";
          enabled = true;
          description = "OISD";
        }
        {
          url = "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext";
          type = "block";
          enabled = true;
          description = "Peter Lowe’s Ad and Tracking Server List";
        }
        {
          url = "https://someonewhocares.org/hosts/zero/hosts";
          type = "block";
          enabled = true;
          description = "Dan Pollock’s Someonewhocares List";
        }
      ];
      settings = {
        dns.upstreams = [
          "9.9.9.9"
          "149.112.112.112"
          "1.1.1.1"
          "1.0.0.1"
        ];
        misc.readOnly = false;
        webserver = {
          api = {
            # To manage the web login:
            # 1) Temporarily set misc.readOnly to false in
            #    configuration.nix and switch to it.
            # 2) Manually set a password:
            #    Pi-hole web console > Settings > All settings >
            #    Webserver and API > webserver.api.password > Value: ******
            # 3) Read the generated hash:
            #    sudo pihole-FTL --config webserver.api.pwhash
            pwhash = "$BALLOON-SHA256$v=1$s=1024,t=32$19N1AHYVF7XKVTDvnvo+Wg==$65Y0pAcb4lCd5jDLML3QF5SvmcxI83n0BtgrnYFxdRk=";
          };
        };
      };
    };
    pihole-web = {
      enable = true;
      ports = [
        "80o"
        "443os"
      ];
    };
  };
}
