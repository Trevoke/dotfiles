{
  description = "A flake for Emacs from the emacs-mirror GitHub repository";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        packages.emacs = pkgs.stdenv.mkDerivation {
          pname = "emacs";
          version = "30.0";

          src = pkgs.fetchFromGitHub {
            owner = "emacs-mirror";
            repo = "emacs";
            rev = "fb15affde8cb27ad358ad7070d150238cec11f99";
            #sha256 = "1dfhc6favkflwq2ilvvl7jfssh74a70nzygkb0h07qs71wmhv855";
            sha256 = "sha256-Ypp0jqXNnH5ktmiza79duuFOufrs6QO8FqkN2LzXF0w=";
          };

          buildInputs = with pkgs; [
            autoconf
            automake
            gnutar
            texinfo
            gzip
            gcc
            xorg.libX11
            xorg.libXpm
            libjpeg
            libpng
            librsvg
            libtiff
            giflib
            gpm
            ncurses
            zlib
            gtk3
            gnutls
            imagemagick
            webkitgtk
            tree-sitter
          ];

          nativeBuildInputs = with pkgs; [
            pkg-config
            makeWrapper
          ];

          configurePhase = ''
            ./autogen.sh
            ./configure --prefix=$out \
            --with-tree-sitter \
            --enable-link-time-optimization \
            --with-x-toolkit=gtk3 \
            --with-imagemagick \
            --with-xwidgets \
            --with-be-cairo
          '';

          buildPhase = "make";

          installPhase = "make install";
        };
      });
}
