#!/bin/bash

# ROG Ally System Information and Diagnostic Script
# Gathers useful system information for troubleshooting

echo "🔍 ROG Ally System Diagnostic Report"
echo "===================================="
echo ""

# Device Information
echo "📱 Device Information:"
echo "---------------------"
echo "Model: $(cat /sys/devices/virtual/dmi/id/product_name 2>/dev/null || echo 'Unknown')"
echo "Manufacturer: $(cat /sys/devices/virtual/dmi/id/sys_vendor 2>/dev/null || echo 'Unknown')"
echo "BIOS Version: $(cat /sys/devices/virtual/dmi/id/bios_version 2>/dev/null || echo 'Unknown')"
echo "BIOS Date: $(cat /sys/devices/virtual/dmi/id/bios_date 2>/dev/null || echo 'Unknown')"
echo ""

# System Information
echo "💻 System Information:"
echo "----------------------"
echo "Kernel: $(uname -r)"
echo "Architecture: $(uname -m)"
echo "Uptime: $(uptime -p)"
if [ -f /etc/os-release ]; then
    echo "OS: $(grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)"
    echo "Version: $(grep VERSION_ID /etc/os-release | cut -d'"' -f2)"
fi
echo ""

# Hardware Information
echo "🔧 Hardware Information:"
echo "------------------------"
echo "CPU: $(lscpu | grep 'Model name' | cut -d':' -f2 | xargs)"
echo "Memory: $(free -h | grep '^Mem:' | awk '{print $2 " total, " $3 " used, " $7 " available"}')"
echo "Storage:"
df -h | grep -E '^/dev/' | while read line; do
    echo "  $line"
done
echo ""

# GPU Information
echo "🎮 Graphics Information:"
echo "-----------------------"
if command -v lspci &> /dev/null; then
    lspci | grep -i vga | while read line; do
        echo "GPU: $line"
    done
    echo ""
fi

# Audio Information
echo "🔊 Audio Information:"
echo "--------------------"
if command -v pactl &> /dev/null; then
    echo "PulseAudio Status: $(systemctl --user is-active pulseaudio)"
    echo "Audio Devices:"
    pactl list short sinks | while read line; do
        echo "  Sink: $line"
    done
    pactl list short sources | while read line; do
        echo "  Source: $line"
    done
else
    echo "PulseAudio not available"
fi
echo ""

# Network Information
echo "🌐 Network Information:"
echo "----------------------"
ip addr show | grep -E '^[0-9]+:' | while read line; do
    interface=$(echo $line | cut -d':' -f2 | xargs)
    status=$(echo $line | grep -o 'state [A-Z]*' | cut -d' ' -f2)
    echo "Interface: $interface - Status: $status"
done
echo ""

# Steam Information
echo "🎮 Steam Information:"
echo "--------------------"
if pgrep -x "steam" > /dev/null; then
    echo "Steam Status: Running"
else
    echo "Steam Status: Not running"
fi

if [ -d "$HOME/.local/share/Steam" ]; then
    echo "Steam Directory: Present"
    steam_size=$(du -sh "$HOME/.local/share/Steam" 2>/dev/null | cut -f1)
    echo "Steam Directory Size: $steam_size"
else
    echo "Steam Directory: Not found"
fi
echo ""

# Decky Loader Status
echo "🔌 Decky Loader Status:"
echo "----------------------"
if [ -d "$HOME/homebrew" ]; then
    echo "Decky Loader: Installed"
    if [ -f "$HOME/homebrew/plugins/.loader.lock" ]; then
        echo "Loader Status: Running"
    else
        echo "Loader Status: Not running"
    fi
    plugin_count=$(find "$HOME/homebrew/plugins" -maxdepth 1 -type d | wc -l)
    echo "Installed Plugins: $((plugin_count - 1))"
else
    echo "Decky Loader: Not installed"
fi
echo ""

# Battery Information (if available)
echo "🔋 Power Information:"
echo "--------------------"
if [ -d "/sys/class/power_supply/BAT0" ]; then
    battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "Unknown")
    battery_status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo "Unknown")
    echo "Battery Level: $battery_capacity%"
    echo "Battery Status: $battery_status"
else
    echo "Battery information not available"
fi

if [ -d "/sys/class/power_supply/ADP1" ]; then
    ac_status=$(cat /sys/class/power_supply/ADP1/online 2>/dev/null || echo "Unknown")
    if [ "$ac_status" = "1" ]; then
        echo "AC Adapter: Connected"
    else
        echo "AC Adapter: Disconnected"
    fi
fi
echo ""

# Performance Information
echo "⚡ Performance Information:"
echo "--------------------------"
echo "Load Average: $(cat /proc/loadavg | cut -d' ' -f1-3)"
echo "CPU Temperature:"
if command -v sensors &> /dev/null; then
    sensors | grep -i temp | head -5
else
    find /sys/devices -name "temp*_input" | head -3 | while read temp_file; do
        if [ -r "$temp_file" ]; then
            temp_value=$(cat "$temp_file")
            temp_celsius=$((temp_value / 1000))
            echo "  Temperature: ${temp_celsius}°C"
        fi
    done
fi
echo ""

# Recent Errors (if any)
echo "⚠️  Recent System Errors:"
echo "-------------------------"
if command -v journalctl &> /dev/null; then
    echo "Last 5 error entries:"
    journalctl -p err -n 5 --no-pager | tail -n +2 || echo "No recent errors found"
else
    echo "journalctl not available"
fi
echo ""

echo "📋 Report completed at $(date)"
echo ""
echo "💡 Tip: You can save this output to a file with:"
echo "   ./system-info.sh > my-system-info.txt"
