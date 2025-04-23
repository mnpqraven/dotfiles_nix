{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.mpd = {
    enable = true;
    musicDirectory = "$HOME/Music";
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
  home.packages = with pkgs; [
    playerctl
    mpc
  ];
  services.mpd-mpris = {
    enable = true;
    mpd.host = "127.0.0.1";
  };

  home.activation.nasMusicSymlink = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ln -sfn /run/mount/nas/music ${config.home.homeDirectory}/Music/nas
  '';
}
