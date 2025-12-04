{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      tree
      wget
      xclip
      fzf
      pavucontrol
      docker-compose
      autorandr

      # External HDD compatibility
      parted
      gptfdisk
      ntfs3g
      exfat
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}
