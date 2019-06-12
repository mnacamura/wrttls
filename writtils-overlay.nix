self: super:

{
  rPackages = super.rPackages // {
    writtils = self.callPackage ./. { pkgs = super; };
  };
}
