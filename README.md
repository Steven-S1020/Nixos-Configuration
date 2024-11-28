<h1 align="center">
  My NixOS Configuration Files
</h1>

<img align="right" width="350" height="350" src="Assets/Other/Nix_Snowflake_Logo.svg">

<br>

<br>

These are my NixOS Configuration Files that I use daily on my current machines.
I have been messing with NixOS, Home Manager, and Flakes since Fall of 2023. 
Below I will include the different hosts that I have inside this configuration.
As well as any specifics That might be useful for someone looking at my setup.
Feel free to copy or adjust any of my dot files, I can't promise it will work but 
I wish you the best of luck.

<br>

<br>

<br>

<br>

<br>

## Hosts

| Hostname | Device Type | Purpose      |
|----------|-------------|--------------|
| Azami    | Laptop      | School       |
| Deimos   | Desktop     | Gaming       |

<br>

## Flake Inputs

- Nixos Hardware

[nixos-hardware](https://github.com/NixOS/nixos-hardware.git) is a collection of NixOS Modules for covering hardware quirks. Due to me deciding to buy a Microsoft Surface before knowing better, I tend to need many specific drivers for my system. The     main issue that prompted me in finding a fix was the laptop failing to power off fully and the screen flickering randomly. Adding this to my flake inputs and a few lines of Config to my flake modules [here](https://github.com/Steven-S1020/Nixos-Configuration/blob/e0d55644fd67f45364d4b5bd64139e7b2ba4f110/flake.nix#L27-L28) mostly fixed the issue. (I later realized the screen flickering was due to Microsoft not knowing how to make Laptops even though it's kinda their job.

<br>

- Stylix

[stylix](https://github.com/danth/stylix.git) is a system wide theming module for NixOS. My main reason for this was due to my obsession with the color red and that there isn't many good red standardized themes for linux. After adding this input to my flake and modules, all I needed to do was create a new config file [here](https://github.com/Steven-S1020/Nixos-Configuration/blob/e0d55644fd67f45364d4b5bd64139e7b2ba4f110/Modules/Configs/stylix.nix)





