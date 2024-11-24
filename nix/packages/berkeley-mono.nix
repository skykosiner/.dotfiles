# make a  derivation for berkeley-mono font installation
{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "berkeley-mono-typeface";
  version = "1.009";

  src = /home/sky/.dotfiles/private_stuff/berkeley-mono-regular.zip;

  unpackPhase = ''
    runHook preUnpack
    ${pkgs.unzip}/bin/unzip $src
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    install -Dm644 ./berkeley-mono-regular.ttf -t $out/share/fonts/
    runHook postInstall
  '';
}

