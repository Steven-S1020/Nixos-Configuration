with import <nixpkgs> { };

mkShell {

  nativeBuildInputs = with python311Packages; [
    flask
    pyyaml
  ];
  
  shellHook = ''
    c
    code .
  '';
}
