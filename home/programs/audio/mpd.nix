{ ... }:
{
  services.mpd = {
    enable = true;
    # NOTE: might need dyn path (`~/Music` or something similar and symlink
    # nas mounts to it)
    musicDirectory = "/run/mount/nas/music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "Pipewire Server"
      }
      # both of these need to be increased/decreased by the same factor of 2
      max_playlist_length "65536"
      max_output_buffer_size "32768"
    '';

    network.listenAddress = "any"; # if you want to allow non-localhost connections
    network.startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
  };
}
