{ lib, python3Packages }:

with python3Packages;
buildPythonApplication {
  pname = "mkdev";
  version = "1.0";
  src = ./src;

  propagatedBuildInputs = [
    flask
    pyyaml
  ];

  postInstall = ''
    mv -v $out/bin/base16.py $out/bin/base16
    cp -r -v $src/themes $out/bin/themes
    cp -r -v $src/templates $out/bin/templates
    cp -r -v $src/static $out/bin/static
  '';
}