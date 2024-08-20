{ python311Packages }:

with python311Packages;
buildPythonApplication {
  pname = "mkdev";
  version = "2.0.2";
  src = pkgs.fetchFromGitHub {
    owner = "4jamesccraven";
    repo = "mkdev";
    rev = "cf003484dcbaae36b2a9de7f66aa696ab6dc87c4";
    sha256 = "1i1sqssnscg4s0ax198rarq2lcfspb6n85fd3ci76rvr5mqkayaj";
  };

  buildInputs = [ python ];

  propagatedBuildInputs = [
    platformdirs
    pyyaml
    textual
  ];

  makeWrapperArgs = [
    "--set PYTHONPATH $src/src/mkdev"
  ];
}
