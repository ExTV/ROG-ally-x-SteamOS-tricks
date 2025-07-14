# ROG Ally SteamOS Setup & Tweaks

<div align="center">

![ROG Ally](https://img.shields.io/badge/Device-ROG%20Ally-red?style=for-the-badge)
![SteamOS](https://img.shields.io/badge/OS-SteamOS-blue?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Community](https://img.shields.io/badge/Community-Driven-orange?style=for-the-badge)

**A comprehensive, community-driven guide for installing and optimizing SteamOS on ASUS ROG Ally devices**

[📖 Installation Guide](#installation-guide) • 
[🔧 Troubleshooting](#known-issues--troubleshooting) • 
[🛠️ Scripts & Tools](#scripts--automation) • 
[🤝 Contributing](CONTRIBUTING.md)

</div>

---

## Table of Contents
- [⚠️ Disclaimer](#disclaimer)
- [🎯 Why SteamOS on Ally?](#why-steamos-on-ally)
- [💿 SteamOS Image](#steamos-image)
- [📚 Installation Guide](#installation-guide)
    - [Prerequisites](#prerequisites)
    - [BIOS Settings (Crucial!)](#bios-settings-crucial)
    - [Installation Steps](#installation-steps)
    - [First Boot & Post-Installation](#first-boot--post-installation)
- [🔧 Known Issues & Troubleshooting](#known-issues--troubleshooting)
    - [Controller Issues](#controller-not-working-in-discover-app-fwupd-issue)
    - [BIOS Problems](#bios-cannot-save-disabling-secure-boot)
    - [Audio Issues](#ui-sounds-not-working)
- [🛠️ Scripts & Automation](#scripts--automation)
- [🔌 Useful Tools & Plugins](#useful-scripts--tools)
- [📖 Documentation](#documentation)
- [🤝 Contributing](#contributing)
- [📄 License](#license)

---

## ⚠️ Disclaimer

> **Important:** Installing a non-native operating system on your ROG Ally carries potential risks, including data loss or unexpected behavior. This guide is provided for informational purposes only, and you proceed at your own risk. 
> 
> **Always back up your data!** Neither this guide nor its maintainers are responsible for any damage or issues that may arise.

## 🎯 Why SteamOS on Ally?
While the ROG Ally comes with Windows, many users find that **SteamOS** offers a superior handheld gaming experience. Benefits often include:

| Feature | Benefit |
|---------|---------|
| 🎮 **Optimized Gaming UI** | A seamless, console-like interface for your game library |
| 🔄 **Proton Compatibility** | Excellent compatibility with Windows games through Valve's Proton |
| 🔋 **Better Battery Life** | Linux-based systems often offer improved power efficiency |
| 👥 **Community Support** | Vibrant community dedicated to handheld Linux gaming |
| 🚀 **Performance** | Reduced overhead compared to Windows for gaming workloads |

## 💿 SteamOS Image
This guide primarily focuses on the installation and setup using **Valve's official Steam Deck recovery image**.

📥 **Download:** [Valve's Official Steam Deck Recovery Image](https://store.steampowered.com/steamos/download/?ver=steamdeck&snr=100601___)

> **Note:** While designed for Steam Deck, this image works well on ROG Ally devices with the configuration steps outlined in this guide.

## 📚 Installation Guide
This section will walk you through the process of getting SteamOS installed on your ROG Ally.

### Prerequisites

Before you begin, make sure you have:

| Item | Description | Links |
|------|-------------|--------|
| 💾 **USB Drive** | 16GB or larger for bootable installer | - |
| 🛠️ **Image Writing Tool** | To create bootable USB | [Rufus](https://rufus.ie/) (Windows) • [Balena Etcher](https://www.balena.io/etcher/) (Cross-platform) |
| 💿 **SteamOS Image** | Official recovery image | [Download here](https://store.steampowered.com/steamos/download/?ver=steamdeck&snr=100601___) |
| 💾 **Backup Storage** | For Windows backup (optional) | External drive or cloud storage |

### BIOS Settings (Crucial!)
Before installing the operating system, you **must** configure specific settings in your ROG Ally's BIOS to ensure compatibility and performance.

> ⚠️ **Critical Step:** These BIOS changes are essential for SteamOS to work properly on your ROG Ally.

#### Step-by-Step BIOS Configuration:

1. **Enter BIOS:**
   - Power off your Ally completely
   - Power on and immediately hold **Volume Down** button
   - Alternative: From Windows, restart and hold **Volume Down** during boot

2. **Enable Advanced Mode:**
   - Once in BIOS, press **'Y'** to switch to Advanced Mode

3. **Disable Secure Boot:**
   - Navigate to **Security** tab (use D-pad right arrow)
   - Scroll down to **Secure Boot** and press **'A'**
   - Set **Secure Boot Control** to `Disabled`
   - Press **'B'** to go back

4. **Save and Exit:**
   - Select "Save Changes and Exit"
   - Confirm your changes

> 💡 **Troubleshooting:** If BIOS won't save changes, disconnect the charger before making changes.

### Installation Steps

#### 1. Create Bootable USB
- Insert your USB drive into your computer
- Open **Rufus** or **Balena Etcher**
- Select your downloaded SteamOS ISO image
- Select your USB drive as the target
- Start the writing process (this may take several minutes)

#### 2. Boot from USB on Ally
- Connect the bootable USB drive to your ROG Ally
  > 💡 **Tip:** You may need a USB-C hub if your Ally only has one USB-C port
- Power on your Ally
- As soon as you see the ROG logo, repeatedly press **Volume Up** button
- Select your USB drive from the boot menu

#### 3. Follow Installation Process
- The SteamOS installer will start automatically
- Follow the on-screen prompts to install SteamOS
- The installation process will partition and format your drive

#### 4. First Boot & Post-Installation
- Remove the USB drive and reboot your Ally
- Complete the initial SteamOS setup process:
  - Connect to Wi-Fi
  - Log into your Steam account
  - Configure basic settings

#### Post-Installation Configuration:
1. **Enable Developer Mode:**
   - Go to **System Settings**
   - Enable **Developer Mode**
   
2. **Configure Update Channels:**
   - Go to **Developer Options**
   - Enable **"Show Advanced Update Channels"**
   - Return to **System Settings**
   - Change update channel from **"Stable"** to **"Main"**

---

## 🔧 Known Issues & Troubleshooting
Here's a comprehensive list of common issues users encounter when running SteamOS on the ROG Ally, along with their solutions.

### Controller Not Working in Discover App (fwupd issue)

**🔍 Problem:** After switching to Desktop Mode and launching the Discover app, the Ally's built-in controller stops responding.

**🔧 Cause:** The Discover app attempts to start `fwupd` (firmware update daemon), which temporarily conflicts with controller input.

**✅ Solution:** 
- Simply **restart your ROG Ally**
- The controller will work normally after reboot
- This issue is usually transient and doesn't affect gaming

### BIOS Cannot Save Disabling Secure Boot

**🔍 Problem:** When attempting to disable Secure Boot in BIOS, changes are not saved and Secure Boot remains enabled.

**🔧 Cause:** Power state interaction when device is connected to charger during BIOS modification.

**✅ Solution:**
1. **Disconnect your ROG Ally from the charger** before entering BIOS
2. Enter BIOS and disable Secure Boot
3. Save changes and exit
4. Reconnect charger after system boots

### UI Sounds Not Working

**🔍 Problem:** Steam Deck UI no longer makes sounds (excluding startup and in-game sounds). Menu navigation is silent.

**🔧 Cause:** Steam application's internal audio (Chromium) was muted in the system's volume mixer.

**✅ Solution:**
1. **Check Steam Settings:** Ensure "Enable UI sound" is checked in **Steam Settings > Audio**
2. **Switch to Desktop Mode**
3. **Play audio from Steam:** Open Steam and play a game trailer or any content with audio
4. **Open volume controls:** Click the speaker icon in the taskbar
5. **Check Applications tab:** Find the volume slider for "Chromium" or Steam process
6. **Unmute and adjust:** Ensure it's unmuted and volume is set appropriately

---

## 🛠️ Scripts & Automation

We've created automated scripts to simplify common tasks and troubleshooting. These scripts are located in the [`scripts/`](scripts/) directory.

### 🚀 Post-Installation Setup Script
**File:** [`scripts/post-install-setup.sh`](scripts/post-install-setup.sh)

Automatically installs Decky Loader and all essential plugins for enhanced ROG Ally experience:
- Installs Decky Loader (plugin manager)
- Automatically installs Simple Decky TDP (TDP control)
- Automatically installs HueSync (LED ring control)  
- Automatically installs PowerControl (fan curves)

```bash
# Download and run
git clone https://github.com/ExTV/ROG-ally-x-SteamOS-tricks.git
cd ROG-ally-x-SteamOS-tricks/scripts
chmod +x post-install-setup.sh
./post-install-setup.sh
```

### 🔍 System Diagnostic Script
**File:** [`scripts/system-info.sh`](scripts/system-info.sh)

Generates comprehensive system information for troubleshooting:
- Hardware details
- System configuration
- Audio/network status
- Performance metrics

```bash
chmod +x system-info.sh
./system-info.sh > system-report.txt
```

> 📚 **More details:** See the [Scripts README](scripts/README.md) for complete documentation.

---

## 🔌 Useful Scripts & Tools
This section provides a curated list of essential tools and plugins that enhance your SteamOS experience on the ROG Ally.

### Essential Plugins

| Plugin | Purpose | Installation |
|--------|---------|--------------|
| 🔌 **[Decky Loader](https://github.com/SteamDeckHomebrew/decky-loader)** | Plugin manager for Steam Deck UI | Automatically installed by script |
| ⚡ **[Simple Decky TDP](https://github.com/aarron-lee/SimpleDeckyTDP)** | TDP and GPU control | Automatically installed by script |
| 🌈 **[HueSync](https://github.com/honjow/HueSync)** | LED ring color control | Automatically installed by script |
| 🔧 **[PowerControl](https://github.com/aarron-lee/PowerControl)** | Fan curves and power management | Automatically installed by script |

### Quick Installation
All plugins are automatically installed by running our [post-installation script](scripts/post-install-setup.sh). No manual steps required!

---

## 📖 Documentation

For more detailed information, check out our comprehensive documentation:

### 📚 Guides Available

| Guide | Description | Audience |
|-------|-------------|----------|
| ❓ **[FAQ](docs/FAQ.md)** | Frequently asked questions and answers | All users |
| 🔧 **[Advanced Configuration](docs/advanced-configuration.md)** | Performance tuning, custom settings, dual-boot setup | Intermediate/Advanced |
| ️ **[Scripts Documentation](scripts/README.md)** | Automation tools and utilities | All users |

### 🔗 Quick Links
- **Performance Optimization**: [Advanced Configuration → Performance](docs/advanced-configuration.md#performance-optimizations)
- **Troubleshooting**: [Advanced Configuration → Troubleshooting](docs/advanced-configuration.md#advanced-troubleshooting)
- **Dual Boot Setup**: [Advanced Configuration → Dual Boot](docs/advanced-configuration.md#dual-boot-setup)

---

## 🤝 Contributing

We welcome contributions from the community! Whether you're fixing bugs, adding new features, or improving documentation, your help makes this project better.

### Ways to Contribute
- 🐛 **Report bugs** or issues you encounter
- 📝 **Improve documentation** with clearer instructions
- 🔧 **Add new troubleshooting solutions**
- 🛠️ **Create helpful scripts** or tools
- 🧪 **Test on different ROG Ally models**

### Getting Started
1. Read our [Contributing Guide](CONTRIBUTING.md)
2. Check existing [issues](../../issues) for ways to help
3. Fork the repository and make your changes
4. Submit a pull request with your improvements

### Community
- 💬 Join discussions in the [Issues](../../issues) section
- 🏷️ Use appropriate labels when creating issues
- 📋 Follow our issue templates for better support

---

## 📄 License
This project is licensed under the [MIT License](LICENSE).
