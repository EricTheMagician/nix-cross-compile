{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    lib = pkgs.lib;
  in {
    packages.${system} = {
      xwin = pkgs.callPackage ./nix/tools/xwin {};
    };
    devShells.x86_64-linux.default = pkgs.mkShell {
      nativeBuildInputs = [
        pkgs.clang_16
        self.packages.${system}.xwin
      ];
      buildInputs = [
      ];
    };
  };
}
