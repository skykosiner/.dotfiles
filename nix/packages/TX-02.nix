{ pkgs, fontPath }:

pkgs.stdenv.mkDerivation {
  pname = "TX-02";
  version = "1.009";

  src = fontPath;

  nativeBuildInputs = [ pkgs.unzip ];
  sourceRoot = ".";
  unpackCmd = "unzip $src";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    # Recursively find all TTF files in case they are in subfolders
    find . -name "*.otf" -exec install -Dm644 {} $out/share/fonts/truetype/ \;

    runHook postInstall
  '';
}

