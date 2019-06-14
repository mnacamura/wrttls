{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  pname = "writtils";
  version = "0.0.0.9000";

  depends = with rPackages; [
    magrittr
    purrr
    stringr
  ];
in

rPackages.buildRPackage {
  name = "${pname}-${version}";

  src = ./.;

  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;

  meta = with lib; {
    description = "R package to provide miscellaneous utilities for prose writing";
    homepage    = https://github.com/mnacamura/writtils;
    license     = with licenses; [ mit ];
    maintainers = with maintainers; [ mnacamura ];
    platforms   = R.meta.platforms;
  };
}
