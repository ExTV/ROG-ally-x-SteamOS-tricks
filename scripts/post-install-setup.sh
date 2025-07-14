#!/bin/bash

# ROG Ally SteamOS Post-Installation Setup Script
# This script automates plugin installation for SteamOS on ROG Ally

echo "🎮 ROG Ally SteamOS Plugin Installation"
echo "======================================"
echo ""

# Function to check if running as deck user
check_user() {
    if [ "$USER" != "deck" ]; then
        echo "❌ This script should be run as the 'deck' user"
        echo "Please switch to the deck user and try again"
        exit 1
    fi
}

# Function to install Decky Loader
install_decky_loader() {
    echo "🔌 Installing Decky Loader..."
    
    if [ -d "$HOME/homebrew" ]; then
        echo "⚠️  Decky Loader appears to already be installed"
        read -p "Do you want to reinstall it? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "⏭️  Skipping Decky Loader installation"
            return
        fi
    fi
    
    # Download and install Decky Loader
    curl -L https://github.com/SteamDeckHomebrew/decky-installer/releases/latest/download/install_release.sh | sh
    
    if [ $? -eq 0 ]; then
        echo "✅ Decky Loader installed successfully"
        echo "📝 Restart Steam to see the new plugins menu"
    else
        echo "❌ Failed to install Decky Loader"
        return 1
    fi
    echo ""
}

# Function to install plugins
install_plugins() {
    echo "📦 Installing essential plugins..."
    echo ""
    
    if [ ! -d "$HOME/homebrew" ]; then
        echo "❌ Decky Loader not found. Please install Decky Loader first."
        return 1
    fi
    
    local installed_count=0
    
    # Ask for Simple Decky TDP
    echo "⚡ Simple Decky TDP (TDP and GPU control)"
    read -p "Install Simple Decky TDP? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "⚡ Installing Simple Decky TDP..."
        curl -L https://github.com/aarron-lee/SimpleDeckyTDP/raw/main/install.sh | sh
        if [ $? -eq 0 ]; then
            echo "✅ Simple Decky TDP installed successfully"
            ((installed_count++))
        else
            echo "❌ Failed to install Simple Decky TDP"
        fi
    else
        echo "⏭️  Skipping Simple Decky TDP"
    fi
    echo ""
    
    # Ask for HueSync
    echo "🌈 HueSync (LED ring color control)"
    read -p "Install HueSync? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "🌈 Installing HueSync..."
        curl -L https://raw.githubusercontent.com/honjow/HueSync/main/install.sh | sh
        if [ $? -eq 0 ]; then
            echo "✅ HueSync installed successfully"
            ((installed_count++))
        else
            echo "❌ Failed to install HueSync"
        fi
    else
        echo "⏭️  Skipping HueSync"
    fi
    echo ""
    
    # Ask for PowerControl
    echo "🔧 PowerControl (fan curves and power management)"
    read -p "Install PowerControl? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "🔧 Installing PowerControl..."
        curl -L https://github.com/aarron-lee/PowerControl/raw/main/install.sh | sh
        if [ $? -eq 0 ]; then
            echo "✅ PowerControl installed successfully"
            ((installed_count++))
        else
            echo "❌ Failed to install PowerControl"
        fi
    else
        echo "⏭️  Skipping PowerControl"
    fi
    echo ""
    
    echo "📦 Plugin installation completed! Summary:"
    echo "  ✅ Decky Loader (plugin manager)"
    if [ $installed_count -gt 0 ]; then
        echo "  ✅ $installed_count additional plugin(s) installed"
    else
        echo "  💡 No additional plugins installed"
        echo "  📝 You can install plugins later through the Decky Store"
    fi
}

# Main execution
main() {
    check_user
    
    echo "This script will install Decky Loader and optionally install essential plugins:"
    echo "  • Decky Loader (plugin manager) - Required"
    echo "  • Simple Decky TDP (TDP control) - Optional"
    echo "  • HueSync (LED ring control) - Optional"
    echo "  • PowerControl (fan curves) - Optional"
    echo ""
    
    read -p "Do you want to continue? (y/N): " -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled"
        exit 0
    fi
    
    install_decky_loader
    
    # Ask user if they want to install plugins
    echo ""
    echo "🔌 Decky Loader installation completed!"
    echo ""
    echo "Would you like to install additional plugins?"
    echo "You'll be asked about each plugin individually:"
    echo "  • Simple Decky TDP (TDP control)"
    echo "  • HueSync (LED ring control)"
    echo "  • PowerControl (fan curves)"
    echo ""
    read -p "Continue with plugin selection? (y/N): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_plugins
    else
        echo "⏭️  Skipping plugin installation"
        echo "💡 You can install plugins later through the Decky Store in Gaming Mode"
    fi
    
    echo "🎉 Setup completed!"
    echo ""
    echo "📋 Next steps:"
    echo "  1. Restart Steam (or reboot your ROG Ally)"
    echo "  2. Go to Gaming Mode"
    echo "  3. Press Steam button and look for plugin icon (🔌)"
    echo "  4. Enjoy your enhanced ROG Ally experience!"
    echo ""
    echo "For more information, visit: https://github.com/ExTV/ROG-ally-x-SteamOS-tricks"
}

# Run the main function
main "$@"
