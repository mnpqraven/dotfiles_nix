_: {
  hardware.pulseaudio.enable = false;
  # Enable sound with pipewire.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  services.mpd = {
    enable = true;
    # NOTE: might need dyn path (`~/Music` or something similar and symlink
    # nas mounts to it)
    musicDirectory = "/run/mount/nas/music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
      # both of these need to be increased/decreased by the same factor of 2
      max_playlist_length "65536"
      max_output_buffer_size "32768"
    '';

    # Optional:
    network.listenAddress = "any"; # if you want to allow non-localhost connections
    startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
  };
}
