{ pkgs, ... }:
{
  # @see https://github.com/tailwindlabs/tailwindcss-intellisense/issues/1380
  nixpkgs.overlays = [
    (final: prev: {
      tailwindcss-language-server = prev.tailwindcss-language-server.overrideAttrs (old: rec {
        src = prev.fetchFromGitHub {
          owner = "tailwindlabs";
          repo = "tailwindcss-intellisense";
          rev = "v0.14.10";
          hash = "sha256-QkidKyns36g+cUY3R20OKZyo0PIO3NOOUL6CnanvvTI=";
        };
        pnpmDeps = prev.pnpm_9.fetchDeps {
          inherit (old)
            pname
            pnpmWorkspaces
            prePnpmInstall
            ;
          inherit src;
          version = "0.14.10";
          hash = "sha256-ODP8HrUNs+0+9v+PDSm8N6t5ixpPoIxZ9Uw5MbdFVA0=";
        };
      });
    })
  ];
  environment.systemPackages = with pkgs; [
    nodejs_20
    pnpm
    tailwindcss-language-server
    emmet-language-server
  ];
}
