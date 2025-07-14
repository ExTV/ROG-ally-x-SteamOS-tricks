# Advanced Configuration Guide

⚠️ **IMPORTANT WARNINGS**:
- This guide contains advanced procedures that can damage your device if done incorrectly
- Hardware control paths vary between different ROG Ally units and firmware versions  
- Always use Decky plugins (PowerControl, Simple Decky TDP) instead of manual commands when possible
- **BACKUP YOUR DATA** before attempting any advanced configuration
- Some commands may not work on your specific hardware configuration

This guide covers advanced configuration options and optimizations for SteamOS on ROG Ally.

## Table of Contents
- [Performance Optimizations](#performance-optimizations)
- [Advanced BIOS Settings](#advanced-bios-settings)
- [Custom Fan Curves](#custom-fan-curves)
- [Dual Boot Setup](#dual-boot-setup)
- [Advanced Troubleshooting](#advanced-troubleshooting)

## Performance Optimizations

### TDP (Thermal Design Power) Management

The ROG Ally's TDP can be adjusted for optimal performance vs battery life balance:

#### Using Simple Decky TDP Plugin
1. Install Decky Loader (see main README)
2. Install Simple Decky TDP using the official installer:
   ```bash
   curl -L https://github.com/aarron-lee/SimpleDeckyTDP/raw/main/install.sh | sh
   ```
   **Note**: This plugin is not available in the Decky Store and must be installed manually
3. Restart Steam to see the plugin
4. Configure TDP settings:
   - **15W**: Maximum battery life, reduced performance
   - **25W**: Balanced performance and battery
   - **30W**: Maximum performance, reduced battery life

#### Manual TDP Control (Desktop Mode)
⚠️ **Warning**: Manual TDP control is advanced and may not work on all ROG Ally units.

```bash
# Check available TDP controls (may vary by device)
find /sys -name "*power*cap*" 2>/dev/null | head -5

# For ROG Ally, TDP is typically controlled via:
# Method 1: AMD platform profile (recommended)
cat /sys/firmware/acpi/platform_profile_choices
echo "performance" | sudo tee /sys/firmware/acpi/platform_profile

# Method 2: Direct power limit (if available)
# Note: Path may not exist on all units
if [ -f /sys/class/hwmon/hwmon4/power1_cap ]; then
    cat /sys/class/hwmon/hwmon4/power1_cap
    # Set TDP to 20W (20000000 microwatts) - USE WITH CAUTION
    echo 20000000 | sudo tee /sys/class/hwmon/hwmon4/power1_cap
else
    echo "Direct TDP control not available - use Decky plugins instead"
fi
```

### GPU Clock Management

#### Using PowerControl Plugin
1. Install PowerControl from Decky Store
2. Configure GPU settings:
   - GPU Clock: 1600MHz (default) to 2000MHz (max)
   - Memory Clock: Adjust based on games

#### Manual GPU Control
⚠️ **Warning**: Manual GPU control may not work reliably on ROG Ally's RDNA 3 integrated graphics.

```bash
# Check GPU information
lspci | grep VGA
cat /sys/class/drm/card*/device/vendor

# For RDNA 3 integrated graphics, try:
# Check current GPU state
cat /sys/class/drm/card*/device/gpu_busy_percent 2>/dev/null || echo "GPU usage info not available"

# AMD GPU power management (may not work on integrated)
cat /sys/class/drm/card*/device/power_dpm_state 2>/dev/null || echo "DPM state not available"

# Set GPU to performance mode (if supported)
if [ -f /sys/class/drm/card0/device/power_dpm_force_performance_level ]; then
    echo "auto" | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level
    echo "Performance mode set (if supported by integrated GPU)"
else
    echo "Manual GPU control not available - use Decky plugins instead"
fi
```

### CPU Governor Settings

```bash
# Check current governor
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Set to performance mode
echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Set to power saving mode
echo "powersave" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

## Advanced BIOS Settings

### Memory Configuration
- **Memory Profile**: Enable XMP/DOCP if available
- **Memory Frequency**: Set to maximum supported speed
- **Memory Timing**: Use automatic or manually tune for stability

### Power Management
- **CPU Power Management**: Enable for better efficiency
- **PCIe Power Management**: Enable for better idle power consumption
- **USB Power Management**: Configure based on peripheral needs

### Advanced Security Settings
- **AMD SVM (Virtualization)**: Enable if using emulation or containers
- **fTPM/PSP**: Can be enabled or disabled based on preference
- **IOMMU**: Enable for better virtualization support
- **Resizable BAR**: Enable for better GPU performance (if available)

## Custom Fan Curves

### Using PowerControl Plugin
1. Access PowerControl settings in Gaming Mode
2. Navigate to Fan Control section
3. Create custom curves:
   ```
   Temperature (°C) | Fan Speed (%)
   30-40           | 20-30
   40-50           | 30-45
   50-60           | 45-65
   60-70           | 65-85
   70+             | 85-100
   ```

### Manual Fan Control (Advanced Users)
⚠️ **DANGER**: Manual fan control can cause overheating and hardware damage. Use PowerControl plugin instead.

```bash
# Check available thermal sensors
find /sys/class/thermal -name "thermal_zone*" | while read zone; do
    echo "Zone: $zone - Type: $(cat $zone/type 2>/dev/null || echo 'unknown')"
done

# Check fan information (READ-ONLY - safer)
find /sys/class/hwmon -name "fan*_input" | while read fan; do
    echo "Fan: $fan - Speed: $(cat $fan 2>/dev/null || echo 'N/A') RPM"
done

# DO NOT USE: Direct PWM control example (DANGEROUS)
# This is for educational purposes only - use PowerControl plugin instead
cat << 'EOF'
#!/bin/bash
# WARNING: This script can damage your device!
# Use PowerControl Decky plugin instead of running this!

while true; do
    # Get CPU temperature
    temp=$(cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null || echo "0")
    temp_c=$((temp / 1000))
    
    # Calculate fan speed (0-255 PWM value)
    if [ $temp_c -lt 40 ]; then
        pwm_value=77   # ~30% (77/255)
    elif [ $temp_c -lt 60 ]; then
        pwm_value=128  # ~50% (128/255)
    else
        pwm_value=204  # ~80% (204/255)
    fi
    
    # DANGEROUS: Writing to PWM control
    # echo $pwm_value > /sys/class/hwmon/hwmon*/pwm1 2>/dev/null
    
    echo "Temperature: ${temp_c}°C, Calculated PWM: $pwm_value (NOT APPLIED)"
    sleep 5
done
EOF
```

**Recommended**: Use the PowerControl Decky plugin for safe fan control instead of manual PWM manipulation.

## Dual Boot Setup

### Prerequisites
- Separate storage device or partition for Windows
- Windows installation media
- SteamOS installation completed first

### Installation Steps
1. **Install SteamOS first** (as per main guide)
2. **Shrink SteamOS partition** (use GParted for safety):
   ```bash
   # In Desktop Mode - BACKUP DATA FIRST!
   # Method 1: Use GParted (recommended)
   sudo pacman -S gparted
   sudo gparted
   # Use GUI to resize partitions safely
   
   # Method 2: Command line (ADVANCED - RISKY)
   # Only if you understand partitioning!
   sudo parted /dev/nvme0n1
   (parted) print free
   (parted) resizepart [partition_number] [new_end_size]
   (parted) quit
   
   # Resize filesystem after partition resize
   sudo resize2fs /dev/nvme0n1p[partition_number]
   ```
3. **Install Windows** in the free space
4. **Fix boot loader** (Windows overwrites GRUB):
   ```bash
   # Boot into SteamOS live USB or chroot
   sudo mount /dev/nvme0n1p[steamos_root] /mnt
   sudo mount /dev/nvme0n1p[efi_partition] /mnt/boot/efi
   sudo arch-chroot /mnt
   grub-install /dev/nvme0n1
   update-grub
   exit
   ```

### Boot Menu Configuration
Add Windows entry to GRUB:
```bash
sudo nano /etc/grub.d/40_custom
```

Add:
```
menuentry "Windows 11" {
    insmod part_gpt
    insmod fat
    search --no-floppy --fs-uuid --set=root [WINDOWS_EFI_UUID]
    chainloader /EFI/Microsoft/Boot/bootmgfw.efi
}
```

Update GRUB:
```bash
sudo update-grub
```

## Advanced Troubleshooting

### Boot Issues

#### Black Screen on Boot
1. **Check BIOS settings**: Ensure Secure Boot is disabled
2. **Try different kernels**: 
   ```bash
   # List available kernels
   ls /boot/vmlinuz-*
   
   # Boot with older kernel if needed
   # (Select from GRUB menu)
   ```
3. **Reset display settings**:
   ```bash
   rm ~/.config/gamescope.conf
   ```

#### Boot Loop
1. **Boot from USB installer**
2. **Mount root partition**:
   ```bash
   sudo mount /dev/nvme0n1p3 /mnt
   sudo mount /dev/nvme0n1p1 /mnt/boot/efi
   ```
3. **Chroot and repair**:
   ```bash
   sudo arch-chroot /mnt
   grub-install /dev/nvme0n1
   update-grub
   ```

### Performance Issues

#### Low FPS in Games
1. **Check TDP settings**: Ensure TDP is set appropriately
2. **Verify Proton version**: Use latest or experimental
3. **Check GPU frequency**: Ensure GPU is not throttling
4. **Monitor temperatures**: Check for thermal throttling

#### Audio Crackling
1. **Adjust buffer size**:
   ```bash
   echo "default-fragments = 8" >> ~/.pulse/daemon.conf
   echo "default-fragment-size-msec = 5" >> ~/.pulse/daemon.conf
   ```
2. **Restart PulseAudio**:
   ```bash
   systemctl --user restart pulseaudio
   ```

### Network Issues

#### Wi-Fi Not Working
1. **Check kernel modules**:
   ```bash
   # Check if Wi-Fi module is loaded
   lsmod | grep -E "(ath11k|mt7921|rtw89)"
   
   # Check Wi-Fi hardware
   lspci | grep -i wireless
   lsusb | grep -i wireless
   ```
2. **Reinstall Wi-Fi drivers**:
   ```bash
   # Update firmware packages
   sudo pacman -Syu linux-firmware
   
   # For common ROG Ally Wi-Fi chips:
   # Realtek (common in some units)
   sudo modprobe -r rtw89_8852be rtw89_8852b rtw89_pci rtw89_core
   sudo modprobe rtw89_8852be
   
   # MediaTek (if present)
   sudo modprobe -r mt7921e mt7921_common mt76_connac_lib mt76
   sudo modprobe mt7921e
   
   # Restart network manager
   sudo systemctl restart NetworkManager
   ```

#### Bluetooth Issues
1. **Reset Bluetooth**:
   ```bash
   sudo systemctl restart bluetooth
   bluetoothctl
   power off
   power on
   ```

### Storage Issues

#### Disk Full
1. **Clean package cache**:
   ```bash
   # Clean package cache (safe)
   sudo pacman -Sc
   
   # More aggressive cleaning (removes all cached packages)
   sudo pacman -Scc
   ```
2. **Remove orphaned packages**:
   ```bash
   # List orphaned packages
   pacman -Qdtq
   
   # Remove orphaned packages (be careful!)
   sudo pacman -Rns $(pacman -Qdtq)
   ```
3. **Clean Steam data**:
   ```bash
   # Clean shader cache (will regenerate)
   rm -rf ~/.local/share/Steam/steamapps/shadercache/*
   
   # Clean download cache
   rm -rf ~/.local/share/Steam/steamapps/downloading/*
   
   # Clean old log files
   find ~/.local/share/Steam/logs -name "*.log" -mtime +30 -delete
   ```

## Recovery Procedures

### System Won't Boot
1. **Boot from USB installer**
2. **Mount system**: 
   ```bash
   sudo mount /dev/nvme0n1p3 /mnt
   ```
3. **Backup important data**:
   ```bash
   cp -r /mnt/home/deck/Documents /backup/
   ```
4. **Reinstall or restore from backup**

### Complete System Reset
1. **Boot from USB installer**
2. **Wipe and reinstall SteamOS**
3. **Restore user data from backup**
4. **Reinstall plugins and configurations**

---

**⚠️ Warning**: Advanced configurations can affect system stability. Always backup your data before making changes.