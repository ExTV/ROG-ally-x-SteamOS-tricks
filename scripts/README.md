# ROG Ally SteamOS Scripts

This directory contains helpful scripts to enhance your SteamOS experience on the ROG Ally.

## Available Scripts

### 🛠️ post-install-setup.sh
Automates common post-installation tasks after installing SteamOS on your ROG Ally.

**Features:**
- Configures developer mode settings
- Installs Decky Loader
- Applies audio configuration fixes  
- Installs useful packages
- Shows system information

**Usage:**
```bash
chmod +x post-install-setup.sh
./post-install-setup.sh
```

### 🔍 system-info.sh
Generates a comprehensive system diagnostic report for troubleshooting.

**Features:**
- Hardware information (CPU, RAM, GPU)
- System configuration details
- Audio and network status
- Steam and Decky Loader status
- Battery and power information
- Recent system errors

**Usage:**
```bash
chmod +x system-info.sh
./system-info.sh

# Save to file for sharing
./system-info.sh > my-system-info.txt
```

## Installation

1. Download the scripts:
```bash
git clone https://github.com/ExTV/ROG-ally-x-SteamOS-tricks.git
cd ROG-ally-x-SteamOS-tricks/scripts
```

2. Make scripts executable:
```bash
chmod +x *.sh
```

3. Run the desired script:
```bash
./post-install-setup.sh
```

## Requirements

- SteamOS installed on ROG Ally
- Run as the `deck` user
- Internet connection (for downloading packages)

## Safety Notes

- ⚠️ **Always backup your data** before running scripts
- 🔍 **Review script contents** before execution
- 🛡️ **Run only from trusted sources**
- 📝 **Create a recovery plan** in case of issues

## Contributing

Found a bug or have a script improvement? Please:
1. Open an issue describing the problem
2. Submit a pull request with your fix
3. Include test results on your ROG Ally

## Support

If you encounter issues:
1. Run `system-info.sh` to gather diagnostic information
2. Check the troubleshooting section in the main README
3. Open an issue with your system information attached
