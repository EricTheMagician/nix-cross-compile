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
    pkgs_16 = import nixpkgs {
      inherit system;
      config = {replaceStdenv = pkgs.clang16Stdenv;};
    };
    lib = pkgs.lib;
    clang = pkgs.clang_16;
    llvm = pkgs.llvmPackages_16.libllvm;
    lld = pkgs.lld_16;
  in {
    packages.${system} = {
      xwin = pkgs.callPackage ./nix/tools/xwin {};
    };
    devShells.x86_64-linux.cross_compile = pkgs.mkShell {
      CC_x86_64_pc_windows_msvc = "${clang}/bin/clang-cl";
      CXX_x86_64_pc_windows_msvc = "${clang}/bin/clang-cl";
      AR_x86_64_pc_windows_msvc = "${llvm}/bin/llvm-lib";
      LDFLAGS = "-Lnative=/home/eric/git/nix-cross-compile/.xwin-cache/crt/lib/x86_64 -Lnative=/home/eric/git/nix-cross-compile/.xwin-cache/sdk/lib/um/x86_64 -Lnative=/home/eric/git/nix-cross-compile/.xwin-cache/sdk/lib/ucrt/x86_64";
      # wine can be quite spammy with log messages and they're generally uninteresting
      WINEDEBUG = "-all";
      # Use wine to run test executables
      CARGO_TARGET_X86_64_PC_WINDOWS_MSVC_RUNNER = "wine";
      # Note that we only disable unused-command-line-argument here since clang-cl
      # doesn't implement all of the options supported by cl, but the ones it doesn't
      # are _generally_ not interesting.
      nativeBuildInputs = [
        clang
        llvm
        lld
        self.packages.${system}.xwin
        pkgs.cmake
        pkgs.cmake-format
      ];
      buildInputs = [
      ];
      shellHook = ''
        export HELLO=WORLD
        export CL_FLAGS="-Wno-unused-command-line-argument -fuse-ld=lld-link /imsvc/home/eric/git/nix-cross-compile/.xwin-cache/splat/crt/include /imsvc/home/eric/git/nix-cross-compile/.xwin-cache/splat/sdk/include/ucrt /imsvc/home/eric/git/nix-cross-compile/.xwin-cache/splat/sdk/include/um /imsvc/home/eric/git/nix-cross-compile/.xwin-cache/splat/sdk/include/shared"
        export CFLAGS_x86_64_pc_windows_msvc="$CL_FLAGS"
        export CXXFLAGS_x86_64_pc_windows_msvc="$CL_FLAGS"
      '';
    };
  };
}
