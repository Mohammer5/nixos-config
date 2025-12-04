{
  services.samba = {
    enable = true;
    securityType = "user";   # sane default
    openFirewall = true;     # opens needed ports automatically

    settings = {
      global = {
        "workgroup"     = "WORKGROUP";
        "server string" = "NixOS Samba Server";
        "netbios name"  = "nixos";
        "map to guest"  = "Bad User";
        "guest account" = "nobody";
      };

      "public" = {
        "path"          = "/mnt/ssd/shared";
        "browseable"    = "yes";
        "read only"     = "no";
        "guest ok"      = "yes";     # allow without password
        "create mask"   = "0644";
        "directory mask"= "0755";
      };
    };
  };

  # optional but nice if you have Windows machines too
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
