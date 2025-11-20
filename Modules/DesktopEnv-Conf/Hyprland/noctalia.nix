{
  pkgs,
  inputs,
  config,
  ...
}:
let
  c = config.colors;
in
{
  # Install Package
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.x86_64-linux.default
  ];

  home-manager.users.steven = {
    # Allow HM to Clobber Noctalia Config File
    xdg.configFile."noctalia/settings.json" = {
      force = true;
    };

    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia-shell = {
      systemd.enable = true;
      enable = true;
      settings = {
        settingsVersion = 23;
        setupCompleted = true;
        bar = {
          position = "top";
          backgroundOpacity = 0;
          monitors = [ ];
          density = "default";
          showCapsule = true;
          capsuleOpacity = 1;
          floating = true;
          marginVertical = 0;
          marginHorizontal = 0;
          outerCorners = false;
          exclusive = true;
          widgets = {
            left = [
              {
                id = "ControlCenter";
                useDistroLogo = true;
                colorizeDistroLogo = false;
                customIconPath = "";
                icon = "";
              }
              {
                id = "SystemMonitor";
                diskPath = "/";
                showCpuTemp = true;
                showCpuUsage = true;
                showDiskUsage = true;
                showMemoryAsPercent = true;
                showMemoryUsage = true;
                showNetworkStats = true;
                usePrimaryColor = false;
              }
              {
                id = "ActiveWindow";
                colorizeIcons = false;
                hideMode = "hidden";
                maxWidth = 225;
                scrollingMode = "hover";
                showIcon = true;
                useFixedWidth = false;
              }
              {
                id = "MediaMini";
                hideMode = "hidden";
                hideWhenIdle = false;
                maxWidth = 145;
                scrollingMode = "hover";
                showAlbumArt = false;
                showArtistFirst = true;
                showVisualizer = false;
                useFixedWidth = false;
                visualizerType = "linear";
              }
            ];
            center = [
              {
                id = "Workspace";
                characterCount = 2;
                hideUnoccupied = false;
                labelMode = "index";
              }
            ];
            right = [
              {
                id = "Tray";
                blacklist = [ ];
                colorizeIcons = false;
                drawerEnabled = true;
                pinned = [ ];
              }
              {
                id = "NotificationHistory";
                hideWhenZero = true;
                showUnreadBadge = true;
              }
              {
                id = "Battery";
                displayMode = "alwaysShow";
                warningThreshold = 20;
              }
              {
                id = "Volume";
                displayMode = "alwaysShow";
              }
              {
                id = "Brightness";
                displayMode = "alwaysShow";
              }
              {
                id = "Clock";
                customFont = "";
                formatHorizontal = "h:mm ap";
                formatVertical = "dddd MMMM-d yyyy";
                useCustomFont = false;
                usePrimaryColor = true;
              }
            ];
          };
        };
        general = {
          avatarImage = "/etc/nixos/Assets/Profile-Pictures/PFP.JPG";
          dimmerOpacity = 0.8;
          showScreenCorners = true;
          forceBlackScreenCorners = true;
          scaleRatio = 0.8;
          radiusRatio = 0.55;
          screenRadiusRatio = 0.55;
          animationSpeed = 1.5;
          animationDisabled = false;
          compactLockScreen = false;
          lockOnSuspend = true;
          enableShadows = false;
          shadowDirection = "bottom_right";
          shadowOffsetX = 2;
          shadowOffsetY = 3;
          language = "";
          allowPanelsOnScreenWithoutBar = true;
        };
        ui = {
          fontDefault = "FiraCode Nerd Font";
          fontFixed = "FiraCode Nerd Font Mono";
          fontDefaultScale = 1;
          fontFixedScale = 1;
          tooltipsEnabled = true;
          panelBackgroundOpacity = 0;
          panelsAttachedToBar = true;
          settingsPanelAttachToBar = false;
        };
        location = {
          name = "Tokyo";
          weatherEnabled = false;
          useFahrenheit = false;
          use12hourFormat = true;
          showWeekNumberInCalendar = false;
          showCalendarEvents = true;
          showCalendarWeather = false;
          analogClockInCalendar = false;
          firstDayOfWeek = 1;
        };
        screenRecorder = {
          directory = "/home/steven/Videos";
          frameRate = 60;
          audioCodec = "opus";
          videoCodec = "h264";
          quality = "very_high";
          colorRange = "limited";
          showCursor = true;
          audioSource = "default_output";
          videoSource = "portal";
        };
        wallpaper = {
          enabled = true;
          overviewEnabled = false;
          directory = "/home/steven/Pictures/Wallpapers";
          enableMultiMonitorDirectories = false;
          recursiveSearch = false;
          setWallpaperOnAllMonitors = true;
          defaultWallpaper = "/etc/nixos/Assets/Wallpapers/Nasa.png";
          fillMode = "crop";
          fillColor = "#000000";
          randomEnabled = false;
          randomIntervalSec = 300;
          transitionDuration = 1500;
          transitionType = "random";
          transitionEdgeSmoothness = 0.05;
          monitors = [ ];
          panelPosition = "follow_bar";
          hideWallpaperFilenames = false;
          useWallhaven = false;
          wallhavenQuery = "";
          wallhavenSorting = "relevance";
          wallhavenOrder = "desc";
          wallhavenCategories = "111";
          wallhavenPurity = "100";
          wallhavenResolutionMode = "atleast";
          wallhavenResolutionWidth = "";
          wallhavenResolutionHeight = "";
        };
        appLauncher = {
          enableClipboardHistory = false;
          position = "center";
          pinnedExecs = [ ];
          useApp2Unit = false;
          sortByMostUsed = true;
          terminalCommand = "kitty -e";
          customLaunchPrefixEnabled = false;
          customLaunchPrefix = "";
        };
        controlCenter = {
          position = "close_to_bar_button";
          shortcuts = {
            left = [
              {
                id = "WiFi";
              }
              {
                id = "Bluetooth";
              }
              {
                id = "ScreenRecorder";
              }
              {
                id = "WallpaperSelector";
              }
            ];
            right = [
              {
                id = "Notifications";
              }
              {
                id = "PowerProfile";
              }
              {
                id = "KeepAwake";
              }
              {
                id = "NightLight";
              }
            ];
          };
          cards = [
            {
              enabled = true;
              id = "profile-card";
            }
            {
              enabled = true;
              id = "shortcuts-card";
            }
            {
              enabled = true;
              id = "audio-card";
            }
            {
              enabled = false;
              id = "weather-card";
            }
            {
              enabled = true;
              id = "media-sysmon-card";
            }
          ];
        };
        systemMonitor = {
          cpuWarningThreshold = 80;
          cpuCriticalThreshold = 90;
          tempWarningThreshold = 80;
          tempCriticalThreshold = 90;
          memWarningThreshold = 80;
          memCriticalThreshold = 90;
          diskWarningThreshold = 80;
          diskCriticalThreshold = 90;
          useCustomColors = false;
          warningColor = "";
          criticalColor = "";
        };
        dock = {
          enabled = true;
          displayMode = "exclusive";
          backgroundOpacity = 1;
          floatingRatio = 0.99;
          size = 0.5;
          onlySameOutput = true;
          monitors = [ ];
          pinnedApps = [ ];
          colorizeIcons = true;
        };
        network = {
          wifiEnabled = true;
        };
        sessionMenu = {
          enableCountdown = true;
          countdownDuration = 10000;
          position = "center";
          showHeader = true;
          powerOptions = [
            {
              action = "lock";
              enabled = true;
              countdownEnabled = true;
            }
            {
              action = "suspend";
              enabled = true;
              countdownEnabled = true;
            }
            {
              action = "hibernate";
              enabled = true;
              countdownEnabled = true;
            }
            {
              action = "reboot";
              enabled = true;
              countdownEnabled = true;
            }
            {
              action = "logout";
              enabled = true;
              countdownEnabled = true;
            }
            {
              action = "shutdown";
              enabled = true;
              countdownEnabled = true;
            }
          ];
        };
        notifications = {
          enabled = true;
          monitors = [ ];
          location = "top_right";
          overlayLayer = true;
          backgroundOpacity = 1;
          respectExpireTimeout = false;
          lowUrgencyDuration = 3;
          normalUrgencyDuration = 8;
          criticalUrgencyDuration = 15;
          enableKeyboardLayoutToast = true;
        };
        osd = {
          enabled = true;
          location = "top_right";
          monitors = [ ];
          autoHideMs = 2000;
          overlayLayer = true;
          backgroundOpacity = 1;
        };
        audio = {
          volumeStep = 5;
          volumeOverdrive = false;
          cavaFrameRate = 30;
          visualizerType = "linear";
          visualizerQuality = "high";
          mprisBlacklist = [ ];
          preferredPlayer = "";
        };
        brightness = {
          brightnessStep = 5;
          enforceMinimum = true;
          enableDdcSupport = false;
        };
        colorSchemes = {
          useWallpaperColors = false;
          predefinedScheme = "Tokyo Night";
          darkMode = true;
          schedulingMode = "off";
          manualSunrise = "06:30";
          manualSunset = "18:30";
          matugenSchemeType = "scheme-fruit-salad";
          generateTemplatesForPredefined = true;
        };
        templates = {
          gtk = false;
          qt = false;
          kcolorscheme = false;
          alacritty = false;
          kitty = false;
          ghostty = false;
          foot = false;
          wezterm = false;
          fuzzel = false;
          discord = false;
          pywalfox = false;
          vicinae = false;
          walker = false;
          code = false;
          spicetify = false;
          enableUserTemplates = false;
        };
        nightLight = {
          enabled = false;
          forced = false;
          autoSchedule = true;
          nightTemp = "4000";
          dayTemp = "6500";
          manualSunrise = "06:30";
          manualSunset = "18:30";
        };
        hooks = {
          enabled = false;
          wallpaperChange = "";
          darkModeChange = "";
        };
        battery = {
          chargingMode = 0;
        };
      };
    };

    xdg.configFile."noctalia/colors.json" = {
      text = builtins.toJSON {
        mError = "#${c.yellow.hex}";
        mHover = "#${c.lightgreen.hex}";
        mOnError = "#${c.black.hex}";
        mOnHover = "#${c.black.hex}";
        mOnPrimary = "#${c.text.hex}";
        mOnSecondary = "#${c.text.hex}";
        mOnSurface = "#${c.text.hex}";
        mOnSurfaceVariant = "#${c.text.hex}";
        mOnTertiary = "#${c.text.hex}";
        mOutline = "#${c.red.hex}";
        mPrimary = "#${c.red.hex}";
        mSecondary = "#${c.purple.hex}";
        mShadow = "#${c.black.hex}";
        mSurface = "#${c.base.hex}";
        mSurfaceVariant = "#${c.black.hex}";
        mTertiary = "#${c.darkred.hex}";
      };
      force = true;
    };

  };
}
