{
  description = "R-devel dev environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    r-devel-nix.url = "github:wch/r-devel-nix";
    r-devel-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, r-devel-nix, nixpkgs }:
    let
      supportedSystems =
        [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" "aarch64-linux" ];
      forEachSupportedSystem = f:
        nixpkgs.lib.genAttrs supportedSystems (system:
          f {
            pkgs = import nixpkgs { inherit system; };
            r-devel = r-devel-nix.packages.${system}.default;
          });
    in {

      devShells = forEachSupportedSystem ({ pkgs, r-devel, ... }: {
        default = pkgs.mkShell {

          packages = with pkgs;
            [
              curl
              git
              wget
              gnumake
              r-devel
              libintl

              # xml2
              libxml2

              # systemfonts
              fontconfig

              # textshaping
              harfbuzz.dev
              freetype.dev
              fribidi
              libpng
              pkg-config

              # ragg
              freetype.dev
              libpng.dev
              libtiff.dev
              zlib.dev
              libjpeg.dev
              bzip2.dev
            ] ++ lib.optionals stdenv.isDarwin [
              # darwin.apple_sdk.frameworks.Cocoa
              darwin.apple_sdk.frameworks.Foundation
              # darwin.libobjc
              # libcxx
            ];

          # Needed for openssl R package
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.openssl ];

          # Needed on Mac
          NIX_LDFLAGS = "-lfribidi -lharfbuzz";

          shellHook = ''
            echo "R-devel shell"
          '';
        };
      });
    };
}
