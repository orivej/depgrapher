with import <nixpkgs> { };

buildGoPackage rec {
  name = "fptrace";
  src = ./.;
  goDeps = ./deps.nix;
  goPackagePath = "github.com/orivej/fptrace";
  preBuild = ''
    mkdir -p $out/bin
    ( cd go/src/$goPackagePath; go run seccomp.go )
    cc go/src/$goPackagePath/_fptracee.c -o $out/bin/_fptracee
    buildFlagsArray=("-ldflags=-X main.tracee=$out/bin/_fptracee")
  '';
}
