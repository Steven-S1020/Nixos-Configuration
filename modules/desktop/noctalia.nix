{
  den,
  __findFile,
  inputs,
  ...
}:
{
  den.aspects.desktop._.noctalia = {
    nixos =
      { inputs', ... }:
      {
        environment.systemPackages = [
          inputs'.noctalia.packages.default
          inputs'.noctalia-qs.packages.default
        ];
      };
    homeManager = {
      imports = [ inputs.noctalia.homeModules.default ];
    };

    includes = [ <desktop/noctalia-hm> ];
  };

  den.aspects.desktop._.noctalia-hm = den.lib.perUser (
    { host, user }:
    let
      hostname = host.hostName;
    in
    {
      homeManager =
        { lib, inputs, ... }:
        let
          noctalia =
            lib: cmd:
            lib.concatStringsSep " " (
              [
                "noctalia-shell"
                "ipc"
                "call"
              ]
              ++ (lib.splitString " " cmd)
            );
          ipc = noctalia lib;
        in
        {
          wayland.windowManager.hyprland.settings = {
            exec = [ "noctalia-shell" ];

            bind = [
              "Alt_L, Space, exec, ${ipc "launcher toggle"}"
              "Alt_L+Shift, Space, exec, ${ipc "launcher toggle"}"
              "$mod, C, exec, ${ipc "launcher calculator"}"
              "$mod, L, exec, ${ipc "lockScreen lock"}"
              "$mod, V, exec, ${ipc "sessionMenu toggle"}"
            ];

            bindel = [
              ", XF86AudioRaiseVolume, exec, ${ipc "volume increase"}"
              ", XF86AudioLowerVolume, exec, ${ipc "volume decrease"}"
              ", XF86MonBrightnessUp, exec, ${ipc "brightness increase"}"
              ", XF86MonBrightnessDown, exec, ${ipc "brightness decrease"}"
            ];

            bindl = [
              ", XF86AudioMute, exec, ${ipc "volume muteOutput"}"
            ];
          };

          programs.noctalia-shell = {
            enable = true;
            settings = lib.mkForce {
              settingsVersion = 54;
              bar = {
                barType = "framed";
                position = "top";
                monitors = [ "eDP-1" ];
                density = "default";
                showOutline = false;
                showCapsule = false;
                capsuleOpacity = 1;
                capsuleColorKey = "none";
                widgetSpacing = 8;
                contentPadding = 0;
                fontScale = 1;
                backgroundOpacity = 0;
                useSeparateOpacity = false;
                floating = false;
                marginVertical = 2;
                marginHorizontal = 2;
                frameThickness = 4;
                frameRadius = 12;
                outerCorners = false;
                hideOnOverview = false;
                displayMode = "always_visible";
                autoHideDelay = 500;
                autoShowDelay = 150;
                showOnWorkspaceSwitch = true;
                widgets = {
                  left = [
                    {
                      colorizeDistroLogo = false;
                      colorizeSystemIcon = "primary";
                      customIconPath = "";
                      enableColorization = false;
                      icon = "";
                      id = "ControlCenter";
                      useDistroLogo = true;
                    }
                    {
                      colorizeIcons = false;
                      hideMode = "hidden";
                      id = "ActiveWindow";
                      maxWidth = 225;
                      scrollingMode = "hover";
                      showIcon = true;
                      textColor = "none";
                      useFixedWidth = false;
                    }
                  ];
                  center = [
                    {
                      characterCount = 2;
                      colorizeIcons = false;
                      emptyColor = "secondary";
                      enableScrollWheel = true;
                      focusedColor = "primary";
                      followFocusedScreen = false;
                      groupedBorderOpacity = 1;
                      hideUnoccupied = false;
                      iconScale = 0.8;
                      id = "Workspace";
                      labelMode = "index";
                      occupiedColor = "secondary";
                      pillSize = 0.6;
                      showApplications = false;
                      showBadge = true;
                      showLabelsOnlyWhenOccupied = true;
                      unfocusedIconsOpacity = 1;
                    }
                    {
                      blacklist = [ ];
                      chevronColor = "none";
                      colorizeIcons = false;
                      drawerEnabled = false;
                      hidePassive = false;
                      id = "Tray";
                      pinned = [ ];
                    }
                  ];
                  right = lib.filter (w: w != null) [
                    {
                      hideWhenZero = true;
                      hideWhenZeroUnread = false;
                      iconColor = "none";
                      id = "NotificationHistory";
                      showUnreadBadge = true;
                      unreadBadgeColor = "primary";
                    }
                    (
                      if hostname == "Azami" then
                        {
                          deviceNativePath = "__default__";
                          displayMode = "icon-always";
                          hideIfIdle = false;
                          hideIfNotDetected = true;
                          id = "Battery";
                          showNoctaliaPerformance = false;
                          showPowerProfiles = false;
                        }
                      else
                        null
                    )
                    {
                      displayMode = "alwaysShow";
                      iconColor = "none";
                      id = "Volume";
                      middleClickCommand = "pwvucontrol || pavucontrol";
                      textColor = "none";
                    }
                    (
                      if hostname == "Azami" then
                        {
                          applyToAllMonitors = false;
                          displayMode = "alwaysShow";
                          iconColor = "none";
                          id = "Brightness";
                          textColor = "none";
                        }
                      else
                        null
                    )
                    {
                      clockColor = "none";
                      customFont = "none";
                      formatHorizontal = "MMM dd";
                      formatVertical = "";
                      id = "Clock";
                      tooltipFormat = "";
                      useCustomFont = false;
                    }
                  ];
                };
                mouseWheelAction = "none";
                reverseScroll = false;
                mouseWheelWrap = true;
                screenOverrides = [ ];
              };
              general = {
                avatarImage = "/etc/nixos/assets/Profile-Pictures/PFP.JPG";
                dimmerOpacity = 0;
                showScreenCorners = false;
                forceBlackScreenCorners = false;
                scaleRatio = 0.85;
                radiusRatio = 0.55;
                iRadiusRatio = 0.55;
                boxRadiusRatio = 1;
                screenRadiusRatio = 0.55;
                animationSpeed = 1.5;
                animationDisabled = false;
                compactLockScreen = true;
                lockScreenAnimations = true;
                lockOnSuspend = true;
                showSessionButtonsOnLockScreen = true;
                showHibernateOnLockScreen = false;
                enableLockScreenMediaControls = false;
                enableShadows = false;
                shadowDirection = "bottom_right";
                shadowOffsetX = 2;
                shadowOffsetY = 3;
                language = "";
                allowPanelsOnScreenWithoutBar = true;
                showChangelogOnStartup = true;
                telemetryEnabled = false;
                enableLockScreenCountdown = true;
                lockScreenCountdownDuration = 10000;
                autoStartAuth = false;
                allowPasswordWithFprintd = false;
                clockStyle = "analog";
                clockFormat = "hh\\nmm";
                passwordChars = true;
                lockScreenMonitors = [ "eDP-1" ];
                lockScreenBlur = 0.25;
                lockScreenTint = 0.5;
                keybinds = {
                  keyUp = [ "Up" ];
                  keyDown = [ "Down" ];
                  keyLeft = [ "Left" ];
                  keyRight = [ "Right" ];
                  keyEnter = [
                    "Return"
                    "Enter"
                  ];
                  keyEscape = [ "Esc" ];
                  keyRemove = [ "Del" ];
                };
                reverseScroll = false;
              };
              ui = {
                fontDefault = "FiraCode Nerd Font";
                fontFixed = "FiraCode Nerd Font Mono";
                fontDefaultScale = 1;
                fontFixedScale = 1;
                tooltipsEnabled = false;
                boxBorderEnabled = true;
                panelBackgroundOpacity = 0.85;
                panelsAttachedToBar = true;
                settingsPanelMode = "attached";
                settingsPanelSideBarCardStyle = true;
              };
              location = {
                name = "Tokyo";
                weatherEnabled = false;
                weatherShowEffects = true;
                useFahrenheit = false;
                use12hourFormat = true;
                showWeekNumberInCalendar = false;
                showCalendarEvents = true;
                showCalendarWeather = false;
                analogClockInCalendar = false;
                firstDayOfWeek = 1;
                hideWeatherTimezone = false;
                hideWeatherCityName = false;
              };
              calendar = {
                cards = [
                  {
                    enabled = true;
                    id = "calendar-header-card";
                  }
                  {
                    enabled = true;
                    id = "calendar-month-card";
                  }
                  {
                    enabled = false;
                    id = "weather-card";
                  }
                ];
              };
              wallpaper = {
                enabled = true;
                overviewEnabled = false;
                directory = "/etc/nixos/assets/Wallpapers";
                monitorDirectories = [ ];
                enableMultiMonitorDirectories = false;
                showHiddenFiles = false;
                viewMode = "browse";
                setWallpaperOnAllMonitors = true;
                fillMode = "crop";
                fillColor = "#000000";
                useSolidColor = false;
                solidColor = "#1a1a2e";
                automationEnabled = false;
                wallpaperChangeMode = "random";
                randomIntervalSec = 300;
                transitionDuration = 500;
                transitionType = "random";
                skipStartupTransition = false;
                transitionEdgeSmoothness = 0.05;
                panelPosition = "follow_bar";
              };
              appLauncher = {
                enableClipboardHistory = false;
                autoPasteClipboard = false;
                enableClipPreview = true;
                clipboardWrapText = true;
                position = "bottom_center";
                pinnedApps = [ ];
                useApp2Unit = false;
                sortByMostUsed = true;
                terminalCommand = "kitty -e";
                customLaunchPrefixEnabled = false;
                customLaunchPrefix = "";
                viewMode = "list";
                showCategories = true;
                iconMode = "tabler";
                showIconBackground = false;
                enableSettingsSearch = false;
                enableWindowsSearch = false;
                enableSessionSearch = false;
                ignoreMouseInput = false;
                screenshotAnnotationTool = "";
                overviewLayer = true;
                density = "default";
              };
              controlCenter = {
                position = "close_to_bar_button";
                openAtMouseOnBarRightClick = true;
                diskPath = "/";
                shortcuts = {
                  left = [
                    {
                      id = "Network";
                    }
                    {
                      id = "Bluetooth";
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
              dock = {
                enabled = false;
                position = "bottom";
                displayMode = "exclusive";
                dockType = "floating";
                backgroundOpacity = 1;
                floatingRatio = 0.75;
                size = 0.5;
                onlySameOutput = true;
                monitors = [ ];
                pinnedApps = [ ];
                colorizeIcons = true;
                showLauncherIcon = false;
                launcherPosition = "end";
                launcherIconColor = "none";
                pinnedStatic = false;
                inactiveIndicators = false;
                groupApps = false;
                groupContextMenuMode = "extended";
                groupClickAction = "cycle";
                groupIndicatorStyle = "dots";
                deadOpacity = 0.6;
                animationSpeed = 1;
                sitOnFrame = false;
                showDockIndicator = false;
                indicatorThickness = 3;
                indicatorColor = "primary";
                indicatorOpacity = 0.6;
              };
              network = {
                wifiEnabled = true;
                airplaneModeEnabled = false;
                bluetoothRssiPollingEnabled = false;
                bluetoothRssiPollIntervalMs = 60000;
                networkPanelView = "wifi";
                wifiDetailsViewMode = "grid";
                bluetoothDetailsViewMode = "grid";
                bluetoothHideUnnamedDevices = false;
                disableDiscoverability = false;
              };
              sessionMenu = {
                enableCountdown = true;
                countdownDuration = 10000;
                position = "center";
                showHeader = true;
                showKeybinds = true;
                largeButtonsStyle = false;
                largeButtonsLayout = "single-row";
                powerOptions = [
                  {
                    action = "lock";
                    command = "";
                    countdownEnabled = true;
                    enabled = true;
                    keybind = "1";
                  }
                  {
                    action = "suspend";
                    command = "";
                    countdownEnabled = true;
                    enabled = true;
                    keybind = "2";
                  }
                  {
                    action = "hibernate";
                    command = "";
                    countdownEnabled = true;
                    enabled = true;
                    keybind = "3";
                  }
                  {
                    action = "reboot";
                    command = "";
                    countdownEnabled = true;
                    enabled = true;
                    keybind = "4";
                  }
                  {
                    action = "logout";
                    command = "";
                    countdownEnabled = true;
                    enabled = true;
                    keybind = "5";
                  }
                  {
                    action = "shutdown";
                    command = "";
                    countdownEnabled = true;
                    enabled = true;
                    keybind = "6";
                  }
                  {
                    action = "rebootToUefi";
                    command = "";
                    countdownEnabled = true;
                    enabled = false;
                    keybind = "";
                  }
                ];
              };
              notifications = {
                enabled = true;
                enableMarkdown = false;
                density = "default";
                monitors = [ ];
                location = "top_right";
                overlayLayer = true;
                backgroundOpacity = 0.85;
                respectExpireTimeout = false;
                lowUrgencyDuration = 3;
                normalUrgencyDuration = 5;
                criticalUrgencyDuration = 8;
                clearDismissed = true;
                saveToHistory = {
                  low = true;
                  normal = true;
                  critical = true;
                };
                sounds = {
                  enabled = false;
                  volume = 0.5;
                  separateSounds = false;
                  criticalSoundFile = "";
                  normalSoundFile = "";
                  lowSoundFile = "";
                  excludedApps = "discord,firefox,chrome,chromium,edge";
                };
                enableMediaToast = false;
                enableKeyboardLayoutToast = true;
                enableBatteryToast = true;
              };
              osd = {
                enabled = true;
                location = "top_right";
                autoHideMs = 2000;
                overlayLayer = true;
                backgroundOpacity = 0.85;
                enabledTypes = [
                  0
                  1
                  2
                  3
                ];
                monitors = [ ];
              };
              audio = {
                volumeStep = 5;
                volumeOverdrive = false;
                cavaFrameRate = 30;
                visualizerType = "linear";
                mprisBlacklist = [ ];
                preferredPlayer = "";
                volumeFeedback = false;
                volumeFeedbackSoundFile = "";
              };
              brightness = {
                brightnessStep = 5;
                enforceMinimum = true;
                enableDdcSupport = false;
                backlightDeviceMappings = [ ];
              };
              colorSchemes = {
                useWallpaperColors = false;
                darkMode = true;
                schedulingMode = "off";
                manualSunrise = "06:30";
                manualSunset = "18:30";
                generationMethod = "tonal-spot";
                monitorForColors = "";
              };
              templates = {
                activeTemplates = [ ];
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
                screenLock = "";
                screenUnlock = "";
                performanceModeEnabled = "";
                performanceModeDisabled = "";
                startup = "";
                session = "";
              };
              plugins = {
                autoUpdate = false;
              };
              idle = {
                enabled = true;
                screenOffTimeout = 0;
                lockTimeout = 500;
                suspendTimeout = 1800;
                fadeDuration = 7;
                screenOffCommand = "";
                lockCommand = "";
                suspendCommand = "";
                resumeScreenOffCommand = "";
                resumeLockCommand = "";
                resumeSuspendCommand = "";
                customCommands = "[]";
              };
              desktopWidgets = {
                enabled = true;
                overviewEnabled = true;
                gridSnap = true;
                monitorWidgets = [
                  {
                    name = "eDP-1";
                    widgets = [
                      {
                        clockColor = "none";
                        clockStyle = "digital";
                        customFont = "";
                        format = "h:mm AP\\n";
                        id = "Clock";
                        roundedCorners = true;
                        scale = 0.8228918483996819;
                        showBackground = false;
                        useCustomFont = false;
                        x = 720;
                        y = 40;
                      }
                      {
                        hideMode = "hidden";
                        id = "MediaPlayer";
                        roundedCorners = false;
                        scale = 1;
                        showAlbumArt = true;
                        showBackground = false;
                        showButtons = true;
                        showVisualizer = true;
                        visualizerType = "wave";
                        x = 880;
                        y = 40;
                      }
                    ];
                  }
                ];
              };
            };
          };
        };
    }
  );
}
