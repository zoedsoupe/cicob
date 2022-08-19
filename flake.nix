{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    rec {
      devShells."${system}".default = with pkgs; mkShell {
        name = "cicob";
        buildInputs = [
          gnumake
          gcc
          readline
          openssl
          zlib
          libxml2
          curl
          libiconv
          elixir
          glibcLocales
          postgresql
          redpanda
        ] ++ lib.optional stdenv.isLinux [
          inotify-tools
          # observer gtk engine
          gtk-engine-murrine
        ]
        ++ lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
          CoreFoundation
          CoreServices
        ]);
      };
    };
}
