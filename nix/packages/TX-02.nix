{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "TX-02";
  version = "1.009";

  src = /home/sky/.dotfiles/private_stuff/font/TX-02.zip;

  unpackPhase = ''
    runHook preUnpack
    ${pkgs.unzip}/bin/unzip $src
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    install -Dm644 ./TX-02-Bold-SemiCondensed-Oblique.otf -t $out/share/fonts
    install -Dm644 ./TX-02-Bold-SemiCondensed.otf -t $out/share/fonts
    install -Dm644 ./TX-02-ExtraBold-SemiCondensed-Oblique.otf -t $out/share/fonts
    install -Dm644 ./TX-02-ExtraBold-SemiCondensed.otf -t $out/share/fonts
    install -Dm644 ./TX-02-Medium-SemiCondensed-Oblique.otf -t $out/share/fonts
    install -Dm644 ./TX-02-Medium-SemiCondensed.otf -t $out/share/fonts
    install -Dm644 ./TX-02-Retina-SemiCondensed-Oblique.otf -t $out/share/fonts
    install -Dm644 ./TX-02-Retina-SemiCondensed.otf -t $out/share/fonts
    install -Dm644 ./TX-02-SemiCondensed-Oblique.otf -t $out/share/fonts
    install -Dm644 ./TX-02-SemiCondensed.otf -t $out/share/fonts
    runHook postInstall
    '';
}

