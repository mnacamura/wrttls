self: super:

{
  rPackages = super.rPackages // {
    wrttls = self.callPackage ./. { pkgs = super; };
  };
}
