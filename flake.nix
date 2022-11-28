{
  inputs = {
    nixpkgs.url = "github:TTTPOB/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    { self
    , nixpkgs
    , flake-utils
    }: flake-utils.lib.eachDefaultSystem (system:
    let pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages = {
        plmc = pkgs.stdenv.mkDerivation {
          name = "plmc";
          src = ./.;
          buildPhase = ''
            make all-openmp
          '';
          installPhase = ''
            mkdir -p $out/bin
            cp bin/plmc $out/bin
          '';
        };
      };
    });
}
