{ nixpkgs ? import <nixpkgs> {} }:

with nixpkgs;

mkShell {
  buildInputs = [ R (callPackage ./. { inherit nixpkgs; }) ];

  shellHook = ''
    R -q --no-save
  '';
}
