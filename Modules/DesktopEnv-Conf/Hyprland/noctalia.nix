{
  pkgs,
  inputs,
  config,
  ...
}:
let
  c = config.colors;
in
{
  # Install Package
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.x86_64-linux.default
  ];

  home-manager.users.steven = {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia-shell = {
      systemd.enable = true;
      enable = true;
    };

    xdg.configFile."noctalia/colors.json" = {
      text = builtins.toJSON {
        mError = "#${c.yellow.hex}";
        mHover = "#${c.lightgreen.hex}";
        mOnError = "#${c.black.hex}";
        mOnHover = "#${c.black.hex}";
        mOnPrimary = "#${c.text.hex}";
        mOnSecondary = "#${c.text.hex}";
        mOnSurface = "#${c.text.hex}";
        mOnSurfaceVariant = "#${c.text.hex}";
        mOnTertiary = "#${c.text.hex}";
        mOutline = "#${c.red.hex}";
        mPrimary = "#${c.red.hex}";
        mSecondary = "#${c.purple.hex}";
        mShadow = "#${c.black.hex}";
        mSurface = "#${c.base.hex}";
        mSurfaceVariant = "#${c.black.hex}";
        mTertiary = "#${c.darkred.hex}";
      };
      force = true;
    };
  };
}
