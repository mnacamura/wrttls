{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  pname = "wrttls";
  version = "0.0.0.9001";

  depends = with rPackages; [
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
    homepage    = https://github.com/mnacamura/wrttls;
    license     = with licenses; [ mit ];
    maintainers = with maintainers; [ mnacamura ];
    inherit (R.meta) platforms;
  };
}
