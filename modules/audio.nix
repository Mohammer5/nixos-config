{ pkgs, ... }: {
  # old setup
  # =========
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
  # hardware.pulseaudio.package = pkgs.pulseaudioFull;

  # modern setup
  # ============
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;   # provides a PulseAudio-compatible server for apps
    jack.enable = true;    # optional, if you need JACK
  };

  services.pulseaudio.enable = false; # make sure the *service* PulseAudio is OFF
}
