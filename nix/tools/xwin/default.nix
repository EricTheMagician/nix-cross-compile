{
  lib,
  rustPlatform,
  fetchFromGitHub,
  stdenv,
  darwin,
}:
rustPlatform.buildRustPackage rec {
  pname = "xwin";
  version = "0.2.14";

  src = fetchFromGitHub {
    owner = "Jake-Shadle";
    repo = "xwin";
    rev = "${version}";
    hash = "sha256-YHAGpkxJA6QFTtK8PZzVRZQwMlyNg/5+OhfA0rnxH7s=";
    # Remove unicode file names which leads to different checksums on HFS+
    # vs. other filesystems because of unicode normalisation.
    #postFetch = ''
    #   rm -r $out/tests/fixtures
    #'';
  };

  cargoHash = "sha256-H/agSPgS098+KLYfF13ZOmlStMN1+h0avh89RCB26rc=";

  buildInputs = lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Foundation
  ];

  doCheck = false;

  meta = with lib; {
    description = "A utility for downloading and packaging the Microsoft CRT headers and libraries, and Windows SDK headers and libraries needed for compiling and linking programs targeting Windows.";
    homepage = "https://github.com/Jake-Shadle/xwin";
    changelog = "https://github.com/Jake-Shadle/xwin/blob/main/CHANGELOG.md";
    license = with licenses; [mit asl20];
    maintainers = with maintainers; [figsoda killercup];
  };
}
