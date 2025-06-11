# ROG Ally/x SteamOS Setup & Tweaks

A community-driven guide and collection of tricks for installing and optimizing **SteamOS** on your **ASUS ROG Ally/x**.

---

## Table of Contents
- [Disclaimer](#disclaimer)
- [Why SteamOS on Ally?](#why-steamos-on-ally)
- [SteamOS image](#SteamOS-image)
- [Installation Guide](#installation-guide)
    - [Prerequisites](#prerequisites)
    - [BIOS Settings (Crucial!)](#bios-settings-crucial)
    - [Installation Steps](#installation-steps)
    - [First Boot & Post-Installation](#first-boot--post-installation)
- [Known Issues & Troubleshooting](#known-issues--troubleshooting)
    - [Controller Not Working in Discover App (fwupd issue)](#controller-not-working-in-discover-app-fwupd-issue)
  - [Useful Scripts & Tools](#useful-scripts--tools)
- [License](#license)

---

## Disclaimer
Installing a non-native operating system on your ROG Ally carries potential risks, including data loss or unexpected behavior. This guide is provided for informational purposes only, and you proceed at your own risk. **Always back up your data!** Neither this guide nor its maintainers are responsible for any damage or issues that may arise.

## Why SteamOS on Ally?
While the ROG Ally comes with Windows, many users find that **SteamOS** offers a superior handheld gaming experience. Benefits often include:
* **Optimized Gaming UI:** A seamless, console-like interface for your game library.
* **Proton Compatibility:** Excellent compatibility with a vast Windows game library through Valve's Proton compatibility layer.
* **Potentially Better Battery Life:** Linux-based systems can sometimes offer better power efficiency.
* **Community-Driven Support:** A vibrant community dedicated to making it work well on non-Steam Deck hardware.

## SteamOS image
This guide primarily focuses on the installation and setup using **Valve's official Steam Deck recovery image**.
* **Valve's official Steam Deck recovery image:** [https://store.steampowered.com/steamos/download/?ver=steamdeck&snr=100601___](https://store.steampowered.com/steamos/download/?ver=steamdeck&snr=100601___)


## Installation Guide
This section will walk you through the process of getting SteamOS installed on your ROG Ally.

### Prerequisites
Before you begin, make sure you have:
1.  **A USB drive (16GB or larger):** This will be used to create your bootable installer.
2.  **An image writing tool:** We recommend [Rufus](https://rufus.ie/) (for Windows) or [Balena Etcher](https://www.balena.io/etcher/) (for Windows/macOS/Linux).
3.  **SteamOS Image:** Download Valve's official Steam Deck recovery image from the link above.

### BIOS Settings (Crucial!)
Before installing the operating system, you **must** configure specific settings in your ROG Ally's BIOS to ensure compatibility and performance.

1.  While powered off, power on your Ally and immediately hold down the **Volume down button** to enter the BIOS utility. (Alternatively, if already in Windows, hit restart, and then hold down Volume Down button).
2.  Once in the BIOS, press 'Y' to switch to **Advanced Mode**.
3.  Navigate to the **Security** tab using the D-pad (right arrow).
4.  D-pad down to **Secure Boot**, and press 'A' to select.
5.  Set **Secure Boot Control** to `Disabled`.
6.  Go back (press 'B').
7.  Select "Save Changes and Exit" and confirm.

### Installation Steps
1.  **Create Bootable USB:**
    * Insert your USB drive into your computer.
    * Open Rufus or Etcher.
    * Select your downloaded ISO image (Steam Deck recovery image) and your USB drive.
    * Start the writing process. This may take a few minutes.
2.  **Boot from USB on Ally:**
    * Connect the prepared bootable USB drive to your ROG Ally (a USB-C hub might be needed if your Ally only has one USB-C port).
    * Power on your Ally. As soon as you see the ROG logo, repeatedly press the **Volume up button** until the boot menu appears.
    * Select your USB drive from the boot options.
3.  **Follow On-Screen Installer Instructions:**
    * The installer will boot. Follow the prompts to install SteamOS .
4.  **First Boot & Post-Installation:**
    * Once the installation is complete, remove the USB drive and reboot your Ally.
    * Your new SteamOS system should now boot. You'll likely go through an initial setup process similar to a Steam Deck, including connecting to Wi-Fi and logging into your Steam account.
    * go to the system settings and enable developer mode and go to the developer option and enable show advanced update channel and go back to system settings and change the channel from stable to main 
---

## Known Issues & Troubleshooting
Here's a list of common issues users encounter when running SteamOS on the ROG Ally and Steam Deck, along with their solutions.

## Controller Not Working in Discover App (fwupd issue)
* **Problem:** After switching to **Desktop Mode** and launching the **Discover app**, the Ally's built-in controller stops responding.
* **Cause:** The Discover app attempts to start `fwupd` (the firmware update daemon), which temporarily conflicts with the controller input. This was identified by the knowledgeable folks in the ROG Ally Discord.
* **Solution:** Simply **restart your ROG Ally**. The controller will work normally after reboot. This issue is usually transient and doesn't affect gaming.

## BIOS Cannot Save Disabling Secure Boot
* **Problem:** When attempting to disable Secure Boot in the ROG Ally's BIOS settings, the changes are not saved upon exiting, and Secure Boot remains enabled.
* **Cause:** This issue can occur due to a power state or a specific interaction when the device is connected to its charger during the BIOS modification process.
* **Solution:** **Disconnect your ROG Ally from the charger** before entering the BIOS and attempting to disable Secure Boot. Make the desired change, save, and exit. The setting should now persist. You can reconnect the charger after the system has booted.

## UI Sounds Not Working 
* **Problem:** The Steam Deck UI no longer makes sounds (excluding the initial startup and in-game sounds). navigating menus and the library is silent. Restarting the device does not resolve this issue.
* **Cause:** The Steam application's internal audio (often handled by Chromium for web content like trailers) was muted in the system's application volume mixer.
* **Note:** Before proceeding with the solution below, please ensure that "Enable UI sound" is checked in your Steam's settings under **Settings > Audio**.
* **Solution:**
    1.  Switch to **Desktop Mode** on your Steam Deck.
    2.  While in Desktop Mode, ensure the Steam application is actively playing audio (e.g., by playing a game trailer in the Steam store page within the app).
    3.  Open the system's audio volume controls (usually by clicking the speaker icon in the taskbar).
    4.  Navigate to the "Applications" or "Playback Devices" tab within the volume mixer.
    5.  Locate the volume slider for "Chromium" (or the specific Steam application process responsible for web content/trailers) and ensure it is unmuted and the volume is set appropriately.


---

## Useful Scripts & Tools
This section provides a curated list of valuable scripts and external tools that enhance your SteamOS experience on the Ally.

* **Decky Loader:** A plugin loader for Steam Deck's UI, allowing for extensive customization and additional functionality.
    * [Download & Installation](https://decky.xyz/download)
* **Simple Decky TDP:** A Decky Loader plugin for more granular control over TDP and GPU settings.
    * [GitHub Repository](https://github.com/aarron-lee/SimpleDeckyTDP)
* **Hue Sync (for LED control):** A plugin to change the LED ring colors on your ROG Ally.
    * [GitHub Repository](https://github.com/honjow/HueSync)
* **PowerControl (Fork for Fan Control):** A fork of a power control plugin, often used for custom fan curves and more.
    * [GitHub Repository](https://github.com/aarron-lee/PowerControl)

---

## License
This project is licensed under the [MIT License](LICENSE).
