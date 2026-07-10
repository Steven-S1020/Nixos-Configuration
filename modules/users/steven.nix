{ __findFile, den, ... }:
{
  den.aspects.steven = {
    includes = [
      <den/primary-user>
      (den._.user-shell "zsh")

      # included every host that steven is (i.e. All Hosts)
      <programs/cli>
    ];

    nixos =
      {
        users.users.steven.openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC1PL0TvhcULpeXSAev5h46IMH/ZxjmFaAcNQptcrSdT steven@Vigil"
        ];
      };
  };
}
