{
  den.aspects.programs._.mayhem.nixos =
    { pkgs, ... }:
    let
      mayhem = pkgs.stdenv.mkDerivation rec {
        pname = "mayhem";
        version = "1.2.3";

        src = pkgs.fetchzip {
          url = "https://github.com/BOTbkcd/mayhem/releases/download/v${version}/mayhem-linux-amd64.tar.gz";
          sha256 = "sha256-P9xK964W09PAlsPNm12UnZ6t/O9KWifUA2pLF6JkScA=";
          stripRoot = false;
        };

        nativeBuildInouts = [ pkgs.autoPatchelfHook ];
        buildInputs = [ pkgs.stdenv.cc.cc.lib ];

        phases = [ "installPhase" ];

        installPhase = ''
          mkdir -p $out/bin
          cp $src/mayhem $out/bin/mayhem
          chmod +x $out/bin/mayhem
        '';
      };
    in
    {
      environment.systemPackages = [ mayhem ];
    };
}
