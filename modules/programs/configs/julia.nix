{
  den.aspects.programs._.julia = {
    nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        (pkgs.julia-bin.withPackages [
          "Revise"
          "OhMyREPL"
          "Plots"
        ])
      ];
    };

    homeManager = {
      home.file.".julia/config/startup.jl".text = ''
        try
            using Revise
        catch e
            @warn "Could not load Revise" exception=e
        end

        try
            using OhMyREPL
        catch e
            @warn "Could not load OhMyREPL" exception=e
        end
      '';
    };
  };
}
