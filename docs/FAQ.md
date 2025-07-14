# Frequently Asked Questions (FAQ)

This document answers common questions about running SteamOS on ROG Ally devices.

## Table of Contents
- [General Questions](#general-questions)
- [Installation Questions](#installation-questions)
- [Performance Questions](#performance-questions)
- [Compatibility Questions](#compatibility-questions)
- [Troubleshooting Questions](#troubleshooting-questions)

## General Questions

### Q: Is it safe to install SteamOS on my ROG Ally?
**A:** While thousands of users have successfully installed SteamOS on their ROG Ally devices, there are always risks when installing a non-official operating system. Always backup your data and understand that this voids your warranty.

### Q: Will I lose Windows completely?
**A:** By default, yes. The installation process will replace Windows entirely. However, you can set up a dual-boot configuration (see our [advanced guide](docs/advanced-configuration.md#dual-boot-setup)) to keep both operating systems.

### Q: Can I go back to Windows?
**A:** Yes, you can always reinstall Windows using ASUS's recovery tools or a fresh Windows installation. However, you'll need to reconfigure everything from scratch.

### Q: How is SteamOS different from Windows on the Ally?
**A:** SteamOS provides:
- Better gaming-focused interface
- Potentially better battery life
- No Windows bloatware
- Free operating system
- However, it has limited non-gaming software compatibility

### Q: Will all my Steam games work?
**A:** Most games work through Proton (Valve's compatibility layer), but not all. Check [ProtonDB](https://www.protondb.com/) for game-specific compatibility information.

## Installation Questions

### Q: How long does the installation take?
**A:** The installation typically takes 30-60 minutes, depending on your storage speed and the size of the SteamOS image.

### Q: What size USB drive do I need?
**A:** A minimum of 16GB is required, but 32GB is recommended for the SteamOS recovery image.

### Q: Do I need to change any BIOS settings?
**A:** Yes, you must disable Secure Boot in the BIOS. See our [installation guide](README.md#bios-settings-crucial) for detailed steps.

### Q: Can I install SteamOS on a microSD card?
**A:** While technically possible, it's not recommended due to poor performance. Use the internal SSD or upgrade to a larger NVMe drive.

### Q: What happens to my existing data?
**A:** The installation will erase all data on the internal drive. Always backup important files before proceeding.

## Performance Questions

### Q: How is gaming performance compared to Windows?
**A:** Performance varies by game:
- **Native Linux games**: Often better performance than Windows
- **Proton games**: Usually 5-15% performance difference (sometimes better, sometimes worse)
- **Anti-cheat games**: Many don't work at all

### Q: How is battery life compared to Windows?
**A:** Most users report 10-30% better battery life on SteamOS, especially for gaming workloads.

### Q: Can I adjust TDP and fan curves?
**A:** Yes, using plugins like Simple Decky TDP and PowerControl. See our [advanced configuration guide](docs/advanced-configuration.md#performance-optimizations).

### Q: What's the maximum TDP I can set?
**A:** The ROG Ally can handle up to 30W TDP, though this significantly impacts battery life.

### Q: Do I get 120Hz display support?
**A:** Yes, SteamOS supports the Ally's 120Hz display for compatible games.

## Compatibility Questions

### Q: Will my Xbox controller work?
**A:** Yes, Xbox controllers have excellent compatibility with SteamOS and work plug-and-play via USB or Bluetooth.

### Q: Can I use external displays?
**A:** Yes, USB-C to HDMI/DisplayPort adapters work well. 4K@60Hz is supported.

### Q: Do USB hubs and docks work?
**A:** Most USB-C hubs and docking stations work fine. Look for hubs with Power Delivery (PD) support for charging while docked.

### Q: Can I upgrade the internal storage?
**A:** Yes, you can upgrade to any M.2 2280 NVMe SSD up to 4TB. The upgrade requires disassembling the device and replacing the existing SSD.

### Q: Will my wireless headphones work?
**A:** Most Bluetooth headphones work, though gaming-specific features may be limited. Wired headphones always work perfectly.

## Troubleshooting Questions

### Q: The controller stopped working in Desktop Mode, what do I do?
**A:** This is a known issue with the Discover app. Simply restart your Ally to fix it.

### Q: I can't save BIOS settings, what's wrong?
**A:** Disconnect the charger before entering BIOS and making changes. This resolves most BIOS saving issues.

### Q: Steam UI has no sound, how do I fix it?
**A:** This is usually caused by muted Chromium audio. See our [troubleshooting guide](README.md#ui-sounds-not-working) for the fix.

### Q: My Wi-Fi isn't working, what should I try?
**A:** Try:
1. Restart the device
2. Check if the Wi-Fi module is loaded: `lsmod | grep -E "(ath11k|mt7921|rtw89)"`
3. Reinstall Wi-Fi drivers (requires developer mode + read-write):
   ```bash
   # Enable read-write mode first
   sudo steamos-readonly disable
   sudo pacman -Syu linux-firmware
   sudo steamos-readonly enable
   ```

### Q: Games are running slowly, what can I check?
**A:** Check:
1. TDP settings (should be 15W+ for demanding games)
2. Proton version (try different versions)
3. GPU frequency scaling
4. Thermal throttling

### Q: The system won't boot after installation, what do I do?
**A:** Try:
1. Ensure Secure Boot is disabled in BIOS
2. Boot from USB installer and repair the bootloader
3. Check our [advanced troubleshooting guide](docs/advanced-configuration.md#advanced-troubleshooting)

### Q: Can I get help if something goes wrong?
**A:** Yes! You can:
1. Check our troubleshooting guides
2. Open an issue on GitHub with your system information
3. Join community Discord servers for real-time help
4. Run our diagnostic script to gather system information

## Advanced Questions

### Q: Can I run Windows games that don't work with Proton?
**A:** Options include:
1. Setting up a dual-boot with Windows
2. Using GPU passthrough with a Windows VM (advanced)
3. Waiting for Proton improvements
4. Using alternative compatibility layers

### Q: How do I backup my SteamOS configuration?
**A:** Key locations to backup:
- `~/.local/share/Steam/` (Steam data)
- `~/homebrew/` (Decky Loader plugins)
- `~/.config/` (system configurations)

### Q: Can I install other Linux distributions?
**A:** Yes, but you'll lose the Steam Deck UI and gaming optimizations. Ubuntu, Fedora, and other distributions can work with some configuration.

### Q: How do I get the latest SteamOS updates?
**A:** Enable developer mode and switch to the "main" update channel for the latest features and fixes.

### Q: Can I contribute to this project?
**A:** Absolutely! See our [contributing guide](CONTRIBUTING.md) for ways to help improve this project.

---

## Still Have Questions?

If your question isn't answered here:

1. **Search existing issues** on our GitHub repository
2. **Check our documentation** in the `docs/` folder
3. **Open a new issue** using our question template
4. **Join community discussions** for real-time help

Remember to include your system information (run our `system-info.sh` script) when asking for help!
