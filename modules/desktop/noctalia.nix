{
  den.aspects.desktop._.noctalia =
    ({ host, ...}:
    {
    nixos =
      { inputs', ... }:
      {
        environment.systemPackages = [
          inputs'.noctalia.packages.default
        ];

        nix.settings = {
          extra-substituters = [ "https://noctalia.cachix.org" ];
          extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
        };
      };
    homeManager = {
          xdg.configFile."hypr/generated/noctalia.lua".text = /* lua */ ''
            hl.on("hyprland.start", function()
                hl.exec_cmd 'noctalia'
            end)

            hl.on("config.reloaded", function()
                hl.exec_cmd 'noctalia-shell'
            end)

            local mod = 'SUPER'
            local ipc = 'noctalia msg'

            hl.bind('ALT + Space', hl.dsp.exec_cmd(ipc .. ' panel-toggle launcher'))
            hl.bind('ALT + Tab', hl.dsp.exec_cmd(ipc .. ' window-switcher'))
            hl.bind(mod .. ' + L', hl.dsp.exec_cmd(ipc .. ' session lock'))
            hl.bind(mod .. ' + V', hl.dsp.exec_cmd(ipc .. ' panel-toggle session'))
            hl.bind('Print', hl.dsp.exec_cmd(ipc .. ' screenshot-fullscreen'))

            hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_cmd(ipc .. ' volume-up'),
                { locked = true, repeating = true })
            hl.bind('XF86AudioLowerVolume', hl.dsp.exec_cmd(ipc .. ' volume-down'),
                { locked = true, repeating = true })
            hl.bind('XF86MonBrightnessUp', hl.dsp.exec_cmd(ipc .. ' brightness-up'),
                { locked = true, repeating = true })
            hl.bind('XF86MonBrightnessDown', hl.dsp.exec_cmd(ipc .. ' brightness-down * 5%'),
                { locked = true, repeating = true })
            hl.bind('XF86AudioMute', hl.dsp.exec_cmd(ipc .. ' mic-mute'), { locked = true })

            ${ if host.hostName == "Deimos" then "
                hl.workspace_rule({ workspace = '1', monitor = 'DP-1', persistent = true })
                hl.workspace_rule({ workspace = '2', monitor = 'DP-1', persistent = true })
            " else ""}
            hl.layer_rule({
              name = "noctalia",
              match = {
                namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd)$",
              },
              no_anim = true,
              ignore_alpha = 0.5,
              blur = true,
              blur_popups = true,
            })
          '';
    };
    });
}
