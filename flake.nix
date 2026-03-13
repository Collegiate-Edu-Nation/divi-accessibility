{
  description = "divi-accessibility Development Environment via Nix Flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
  };

  outputs =
    { nixpkgs, ... }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forEachSupportedSystem =
        function:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          function {
            pkgs = nixpkgs.legacyPackages.${system};
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              nodejs
              php
              eslint
            ];

            shellHook = ''
              export PS1="\n\[\033[1;31m\][devShell:\w]\$\[\033[0m\] "
              echo -e "\ndivi-accesibility Development Environment via Nix Flake\n"
            '';
          };
        }
      );
    };
}
