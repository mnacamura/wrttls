self: super:

{
  rPackages = super.rPackages // {
    writtils = super.callPackage ./. { nixpkgs = super; };
  };
}
