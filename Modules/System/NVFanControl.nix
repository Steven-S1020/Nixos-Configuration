# Credit: https://github.com/JGtHb/NVFanControl
#
# Run to let service control fans,
# sudo nvidia-settings -a gpufancontrolstate=1
#
# Check state with,
# systemctl status NVFanControl
#
# Run to set fans back to automatic,
# sudo nvidia-settings -a gpufancontrolstate=0
#
{ pkgs, ... }:

{

  systemd.timers.NVFanControl = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "1s";
      OnUnitActiveSec = "1s";
    };
  };

  systemd.services.NVFanControl = {
    enable = true;
    description = "NVIDIA Fan Control Bash Script";
    serviceConfig = {
      Type = "oneshot";
    };
    path = [ pkgs.gawk ]; # used for sine wave curve calc
    wantedBy = [ "default.target" ];
    partOf = [ "default.target" ];
    script = ''
      declare -i gpuTemp
      declare -i gpuTempClamp
      declare -i targetFanSpeed
      declare -i finalFanSpeed

      gpuTemp=$(/run/current-system/sw/bin/nvidia-settings -q gpucoretemp -c 0 2> /dev/null | grep -Po "(?<=: )[0-9]+(?=\.)")

      # Clamp the temperature range between 50°C and 85°C
      gpuTempClamp=$((gpuTemp < 50 ? 50 : (gpuTemp > 85 ? 85 : gpuTemp)))

      # Map 50–85°C to a smooth sine-like fan curve from 50% to 100%
      # sin() runs from -π/2 to π/2 for smooth easing
      targetFanSpeed=$(gawk -v temp=$gpuTempClamp 'BEGIN{
        # Map temp 50–85 → angle -pi/2 → pi/2
        angle = (temp - 50) * (3.14159 / 35) - (3.14159 / 2)
        # Calculate fan speed 50–100 with smooth ramp
        printf "%.0f", (25 * (sin(angle) + 1) + 50)
      }')

      finalFanSpeed=$((targetFanSpeed > 100 ? 100 : targetFanSpeed))
      echo "Current Temp: $gpuTemp°C | Target Fan Speed: $finalFanSpeed%"
      /run/current-system/sw/bin/nvidia-settings -a GPUTargetFanSpeed="$finalFanSpeed" -c 0
    '';
  };
}
