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

## Hosts

| Hostname | Device Type | Purpose      | CPU            | GPU             | MEM        | DE    |
|----------|-------------|--------------|----------------|-----------------|------------|-------|
| Azami    | Laptop      | School       | Ryzen 5 5600X  | Nvidia 3070 LHR | 32 GB DDR4 | GNOME |
| Deimos   | Desktop     | Gaming       | Intel i7-1255U | Integrated      | 16 GB DDR5 | GNOME |

<br>

## Flake Inputs

- Nixos Hardware

[nixos-hardware](https://github.com/NixOS/nixos-hardware.git) is a collection of NixOS Modules for covering hardware quirks. Due to me deciding to buy a Microsoft Surface before knowing better, I tend to need many specific drivers for my system. The     main issue that prompted me in finding a fix was the laptop failing to power off fully and the screen flickering randomly. Adding this to my flake inputs and a few lines of Config to my flake modules [here](https://github.com/Steven-S1020/Nixos-Configuration/blob/e0d55644fd67f45364d4b5bd64139e7b2ba4f110/flake.nix#L27-L28) mostly fixed the issue. (I later realized the screen flickering was due to Microsoft not knowing how to make Laptops even though it's kinda their job.)

<br>

- Stylix

[stylix](https://github.com/danth/stylix.git) is a system wide theming module for NixOS. My main reason for this was due to my obsession with the color red and that there isn't many good red standardized themes for linux. After adding this input to my flake and modules, all I needed to do was create a new config file [here](https://github.com/Steven-S1020/Nixos-Configuration/blob/e0d55644fd67f45364d4b5bd64139e7b2ba4f110/Modules/Configs/stylix.nix)

<br>

- Mkdev

[mkdev](https://github.com/4jamesccraven/mkdev.git) is a command line tool to copy and deploy frequently used scripts and projects. Not only is this made by one of my friends, but I use it daily for quickly creating new projects. This in combination with [ultisnips](https://github.com/SirVer/ultisnips.git) speeds up my coding workflow.

- Zen Browser

[zen-browser](https://github.com/youwen5/zen-browser-flake.git) is a new browser that isn't in nixpkgs yet. I've been keeping an eye on it since it launched, but it's taking longer than expected to reach a stable build for nixpkgs.

<br>

## Personal Notes

### Installation

```
cd /etc/nixos
sudo chown -R steven:steven .
nix-shell -p git --run "git clone git@github.com:Steven-S1020/Nixos-Configuration.git ."
sudo nixos-rebuild switch --flake #<FlakeHost>
```

### Updating

For all inputs:
```
cd etc/nixos
nix flake update
```
For specific inputs:
```
cd etc/nixos
nix flake update <InputName>
```
