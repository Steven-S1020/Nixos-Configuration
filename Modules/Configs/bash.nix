# Bash Configuration

{ ... }:

{
  home-manager.users.steven = {
    programs.bash = {

      enable = true;

      # Command ran on open of Alacritty
      initExtra = ''
        fastfetch
      '';

      # Prompt Color
      bashrcExtra = ''
         PS1="\[\e[37m\]|\[\e[38;2;172;66;66m\]\u@\h\[\e[37m\]|\e[38;2;172;66;66m\] \w\[\e[37m\]\n󱎃 \[\e[0m\]" 
      '';

      # Shell Aliases 
      shellAliases = {
      	home = "cd ~";
        nix-home = "cd /etc/nixos";
        cat = "bat";
        ff = "fastfetch";
        cff = "clear && ff";
        ls = "lsd";
        la = "ls -a";
        lla = "ls -la";
        lt = "ls --tree --group-dirs first";
        create = "python /etc/nixos/Modules/Scripts/create.py";
        build = "sudo nixos-rebuild switch --flake /etc/nixos";
        clean-and-build = "nix-collect-garbage&&sudo nix-collect-garbage -d&&sudo nixos-rebuild switch --flake /etc/nixos";

      };
    };
  };
}

