{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  pname = "writtils";
  version = "0.0.0.9000";

  depends = with rPackages; [
  ];
in

rPackages.buildRPackage {
  name = "${pname}-${version}";

  src = ./.;

  propagatedBuildInputs = depends;
  nativeBuildInputs = depends;

  meta = with lib; {
    description = "Utilities for writing";
    homepage    = https://github.com/mnacamura/writtils;
    license     = with licenses; [ mit ];
    maintainers = with maintainers; [ mnacamura ];
    platforms   = R.meta.platforms;
  };
}
