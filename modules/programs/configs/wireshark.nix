
{
  den.aspects.programs._.wireshark =
    { user, ... }:
    {
      nixos =
      { pkgs, ... }:
      {
        programs.wireshark.enable = true;
        users.users.${user.userName}.extraGroups = [ "wireshark" ];
        environment.systemPackages = with pkgs; [
          wireshark
        ];
      };
    };
}
