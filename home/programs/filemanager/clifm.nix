{pkgs, ...}: {
  home.packages = with pkgs; [
    clifm
  ];
}
