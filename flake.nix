{
  description = "Learn You a Haskell development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            ghc
            cabal-install
            haskell-language-server
            stack
          ];

          shellHook = ''
            echo "Learn You a Haskell development environment"
            echo "GHC version: $(ghc --version)"
            echo "Available tools: ghc, cabal, stack, haskell-language-server"
          '';
        };
      }
    );
}
