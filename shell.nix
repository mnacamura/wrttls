with import <nixpkgs> {};

mkShell {
  inputsFrom = [ (import ./default.nix {}) ];
  buildInputs = with rPackages; [
    devtools
    roxygen2
    testthat
    usethis
  ];

  shellHook = ''
    export MANPATH="${R}/share/man''${MANPATH:+:}$MANPATH"
  '';
}
