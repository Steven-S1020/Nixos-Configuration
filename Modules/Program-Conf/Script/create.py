# Scripy to Auto Create Configuration Files for Nixos and Home-Manager

import argparse

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('file', help='Name of file to write to')
    args = parser.parse_args()

    CONTENTS = [
            f'# {args.file} Configuration',
            '',
            '{ config, pkgs, lib, ... }:',
            '',
            '{',
            '  home-manager.users.steven = {',
            f'    programs.{args.file} = {{',
            '',
            '      enable = true;',
            '',
            '',
            '',
            '    };',
            '  };',
            '}',
            ''
            ]

    fileName = f'{args.file}.nix'

    with open(fileName, 'w') as f:
        f.write('\n'.join(CONTENTS))


if __name__ == '__main__':
    main()
