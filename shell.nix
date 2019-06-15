with import <nixpkgs> {};

mkShell {
  inputsFrom = [ (callPackage ./. {}) ];
  buildInputs = with rPackages; [
    devtools
    lintr
    roxygen2
    testthat
    usethis
  ];

  shellHook = ''
    export MANPATH="${R}/share/man''${MANPATH:+:}$MANPATH"
  '';
}
