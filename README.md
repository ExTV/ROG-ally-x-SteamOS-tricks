ROG Ally SteamOS Setup & Tweaks
A community-driven guide and collection of tricks for installing and optimizing SteamOS (and SteamOS-like distributions) on your ASUS ROG Ally.

Table of Contents
Disclaimer
Why SteamOS on Ally?
Supported SteamOS Builds
Installation Guide
Prerequisites
BIOS Settings
Installation Steps
Known Issues & Troubleshooting
Controller Not Working in Discover App (fwupd issue)
Wi-Fi/Bluetooth Problems
Fan Control & TDP
Performance Tweaks & Optimizations
Recommended Game Settings
Battery Life Tips
Useful Scripts & Tools
Contributing
Community Resources
License
Disclaimer
Installing a non-native operating system on your ROG Ally carries potential risks, including data loss or unexpected behavior. This guide is provided for informational purposes only, and you proceed at your own risk. Always back up your data! Neither this guide nor its maintainers are responsible for any damage or issues that may arise.

Why SteamOS on Ally?
While the ROG Ally comes with Windows, many users find that SteamOS (or SteamOS-like distributions like Bazzite) offers a superior handheld gaming experience. Benefits often include:

Optimized Gaming UI: A seamless, console-like interface for your game library.
Proton Compatibility: Excellent compatibility with a vast Windows game library through Valve's Proton compatibility layer.
Potentially Better Battery Life: Linux-based systems can sometimes offer better power efficiency.
Community-Driven Support: A vibrant community dedicated to making it work well on non-Steam Deck hardware.
Supported SteamOS Builds
This guide primarily focuses on the installation and setup for:

HoloISO: A community project aiming to replicate SteamOS 3.0.
Bazzite: A Fedora-based Linux distribution designed to provide a Steam Deck-like experience on other hardware.
Please note: While the general principles apply, specific steps might vary slightly between builds.
Installation Guide
This section will walk you through the process of getting SteamOS (or your chosen SteamOS-like distribution) installed on your ROG Ally.

Prerequisites
Before you begin, make sure you have:

A USB drive (16GB or larger): This will be used to create your bootable installer.
An image writing tool: We recommend Rufus (for Windows) or Balena Etcher (for Windows/macOS/Linux).
The chosen SteamOS/HoloISO/Bazzite ISO image:
[Link to HoloISO download page]
[Link to Bazzite download page]
BIOS Settings
For optimal compatibility and performance with SteamOS, it's crucial to adjust a few settings in your ROG Ally's BIOS:

Power on your Ally and repeatedly press the Volume Down button immediately after pressing the power button to enter the BIOS.
Navigate to Advanced > AMD CBS > NBIO Common Options.
Set UMA Buffer Size to 4G (or 8G if you have 16GB of RAM and want to allocate more to the iGPU).
[Add any other relevant BIOS settings here, potentially with screenshots or specific navigation paths. For example, disabling Secure Boot if necessary for some builds.]
Save your changes and exit the BIOS.
Installation Steps
Create Bootable USB:
Insert your USB drive into your computer.
Open Rufus or Etcher.
Select your downloaded ISO image and your USB drive.
Start the writing process. This may take a few minutes.
Boot from USB on Ally:
Connect the prepared bootable USB drive to your ROG Ally (a USB-C hub might be needed if your Ally only has one USB-C port).
Power on your Ally. As soon as you see the ROG logo, repeatedly press the Volume Down button again until the boot menu appears.
Select your USB drive from the boot options.
Follow On-Screen Instructions:
The installer will boot. Follow the prompts to install SteamOS. This typically involves selecting your language, time zone, and target drive.
[Add any specific quirks or common steps for the chosen installer, e.g., "choose 'Expert Install' if available," "ensure you wipe the drive," etc.]
First Boot & Post-Installation:
Once the installation is complete, remove the USB drive and reboot your Ally.
SteamOS should now boot. You'll likely go through an initial setup similar to a Steam Deck, including Wi-Fi setup and logging into your Steam account.
[Add any immediate post-installation commands or actions, e.g., sudo steamos-update if applicable.]
Known Issues & Troubleshooting
Here's a list of common issues users encounter when running SteamOS on the ROG Ally, along with their solutions.

Controller Not Working in Discover App (fwupd issue)
Problem: After switching to Desktop Mode and launching the Discover app, the Ally's built-in controller stops responding.
Cause: The Discover app attempts to start fwupd (the firmware update daemon), which temporarily conflicts with the controller input. This was identified by the knowledgeable folks in the ROG Ally Discord.
Solution: Simply restart your ROG Ally. The controller will work normally after reboot. This issue is usually transient and doesn't affect gaming.
Wi-Fi/Bluetooth Problems
Problem: Wi-Fi or Bluetooth isn't working after installation, or it's unstable.
Solution: This often comes down to missing or incorrect drivers.
Check for specific kernel modules or driver packages that might be needed for your Ally's Wi-Fi card.
Sometimes, updating the system (sudo pacman -Syu on Arch-based systems) can pull in newer kernel modules that resolve this.
[Provide specific commands if known, or link to a script that installs required drivers.]
Fan Control & TDP
Problem: Fans are running too high/low, or you can't control TDP (Thermal Design Power).
Solution: Native support for these features might not be present out-of-the-box.
Look for community-developed tools or scripts that allow fine-grained control over fan curves and TDP limits.
[Link to specific GitHub repositories or scripts that address this.]
Hint: Tools like ally-controller or similar might be useful.
Performance Tweaks & Optimizations
Get the most out of your ROG Ally with these performance tips.

Recommended Game Settings
Proton Version: Experiment with different Proton versions (GE-Proton often offers better performance or compatibility for certain games).
In-Game Settings: Start with low/medium settings and adjust upwards. The Ally is powerful, but SteamOS might behave differently than Windows.
FSR/RSR: Leverage AMD's FSR (FidelityFX Super Resolution) in supported games or RSR (Radeon Super Resolution) at the driver level for better framerates at lower resolutions.
Battery Life Tips
Reduce screen brightness.
Limit TDP/CPU clock speeds when playing less demanding games.
Disable unnecessary background processes.
Useful Scripts & Tools
This section will contain links to or directly host useful scripts and external tools that enhance your SteamOS experience on the Ally.

[Link to SCRIPTS/ directory in this repo]
[Links to other helpful community tools, e.g., EmuDeck installation, specific controller utilities.]
Contributing
We welcome and encourage contributions to make this guide even better! If you have a new trick, a fix for a known issue, or want to improve existing documentation, please follow these steps:

Open an issue: Start by creating an issue to discuss your proposed change or addition.
Fork the repository: Create your own copy of this repository on GitHub.
Create a new branch: git checkout -b my-new-feature
Make your changes: Implement your improvements.
Commit your changes: git commit -m 'Add new feature X / Fix issue Y'
Push to the branch: git push origin my-new-feature
Open a Pull Request: Submit a pull request from your forked repository to this main one.
Community Resources
Join the conversation and get more help from these great communities:

ROG Ally Discord Server: [Link to a relevant ROG Ally Discord server]
r/ROGAlly (Reddit): https://www.reddit.com/r/ROGAlly/
r/SteamOS (Reddit): https://www.reddit.com/r/SteamOS/
r/Linux_Gaming (Reddit): https://www.reddit.com/r/Linux_Gaming/
License
This project is licensed under the MIT License.
