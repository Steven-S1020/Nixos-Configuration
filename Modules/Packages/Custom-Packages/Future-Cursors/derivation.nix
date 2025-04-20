{
  pkgs,
  lib,
  ...
}:


let
  Future-cursors = { style ? "svg" }: pkgs.stdenvNoCC.mkDerivation {
    pname = "Future-cursors";
    version = "0.1.0";
    src = pkgs.fetchFromGitHub {
      owner = "yeyushengfan258";
      repo = "Future-cursors";
      rev = "587c14d2f5bd2dc34095a4efbb1a729eb72a1d36";
      hash = "sha256-ziEgMasNVhfzqeURjYJK1l5BeIHk8GK6C4ONHQR7FyY=";
    };

    nativeBuildInputs = with pkgs; [
      bash
      xorg.xcursorgen
      imagemagick
      fd
    ];

    buildPhase = # bash
      ''
        # Move all of the source files to the cwd
        # so we can manipulate them
        cp -r $src/src .
        # Take in the cursor style from cli or default to "svg"
        SVG_SOURCE="${style}"
        # Assume source and output files, but allow overriding
        SOURCE="$(pwd)/src"
        DIST="$(pwd)/dist"
        # Assert that the style is valid
        case "$SVG_SOURCE" in
            svg|svg-dark|svg-black|svg-cyan);;
            *) echo "''${SVG_SOURCE} is not supported."; exit 1;;
        esac
        # Delete previous attempts to make dist
        if [ -d "$DIST" ]; then
            rm -fr "$DIST"
        fi
        # Rasterise svgs to pngs
        echo -ne "Rasterising images... \r"
        fd . -e svg "$SOURCE/$SVG_SOURCE" | while read file; do
            # Get the base file name witout extension
            name=$(basename $file)
            name="''${name%.svg}"
            # Create the necessary png files in our source directory
            magick "$file" -resize 32x32 "$SOURCE/x1/$name.png"
            magick "$file" -resize 40x40 "$SOURCE/x1_25/$name.png"
            magick "$file" -resize 48x48 "$SOURCE/x1_5/$name.png"
            magick "$file" -resize 60x60 "$SOURCE/x2/$name.png"
        done
        echo "Rasterising images... DONE."
        cd $SOURCE
        echo -ne "Generating cursor theme... \r"
        # We want to be targeting ./dist/cursors
        BUILD="$DIST/cursors"
        mkdir -p "$BUILD"
        for CUR in "config/"*.cursor; do
            # basename w/o extension
            BASENAME=$(basename "$CUR")
            BASENAME="''${BASENAME%.cursor}"
            # Use xcursorgen to make the files
            xcursorgen "$CUR" "$BUILD/$BASENAME"
        done
        echo "Generating cursor theme... DONE."
        ALIASES="$SOURCE/cursorList"
        cd "$DIST/cursors"
        echo -ne "Generating shortcuts... \r"
        while read ALIAS; do
            # Parse files line by line, splitting on spaces
            FROM="''${ALIAS#* }"
            TO="''${ALIAS% *}"
            if [ -e $TO ]; then
                continue
            fi
            # Make the necessary symbolic links
            ln -sr "$FROM" "$TO"
        done < "$ALIASES"
        echo "Generating shortcuts... DONE."
        cd "$DIST/.."
        if [ -z "$THEME_NAME" ]; then
            SUFFIX="''${SVG_SOURCE#svg-}"
            case "$SUFFIX" in
                svg) THEME_NAME="Future-cursors";;
                *) THEME_NAME="Future-cursors-$SUFFIX";;
            esac
        fi
        echo -ne "Generating theme index... \r"
        echo -e "[Icon Theme]\nName=$THEME_NAME\n" > "$DIST/index.theme"
        echo "Generating theme index... DONE."
      '';

    installPhase = ''
      mkdir -p $out/share/icons/Future-cursors
      cp -r dist/* $out/share/icons/Future-cursors
    '';

    meta = {
      description = "Future cursors for linux desktops";
      homepage = "https://github.com/yeyushengfan258/Future-cursors";
      license = lib.licenses.gpl3;
      maintainers = [
        {
          name = "James Craven";
          email = "4jamesccraven@gmail.com";
          github = "4jamesccraven";
          githubId = 142930758;
        }
      ];
    };
  };
in
{
  environment.systemPackages = [
    (Future-cursors { style = "svg-black"; })
  ];
}
