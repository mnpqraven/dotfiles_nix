{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    omnisharp-roslyn
    roslyn-ls
    csharp-ls
  ];
}
