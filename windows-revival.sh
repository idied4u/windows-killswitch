# Reverse Windows Revival Shell Script.
Write-Host "=== Reverse SilentKill: Windows Network Lockdown ==="

# Requires admin
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "You must run this script as Administrator!"
    exit
}

# Re-enable all network adapters
Write-Host "[+] Re-enabling all network adapters..."
Get-NetAdapter | Enable-NetAdapter -Confirm:$false

# Remove all inbound and outbound traffic blocking rules from the Windows Firewall
Write-Host "[+] Re-enabling all inbound and outbound traffic in Windows Firewall..."
Remove-NetFirewallRule -DisplayName "SilentKill-In-All"
Remove-NetFirewallRule -DisplayName "SilentKill-Out-All"

# Re-enable Bluetooth service (if it was disabled)
Write-Host "[+] Re-enabling Bluetooth service..."
Set-Service bthserv -StartupType Manual
Start-Service bthserv

# Re-enable USB devices (Ethernet over USB, USB tethering, etc.)
Write-Host "[+] Re-enabling USB devices..."
$blockList = @(
    "USB\VID*",               # Generic USB devices
    "PCI\VEN*",               # PCI NICs
    "*TAP*",                  # Virtual interfaces (e.g. VPN)
    "*NDIS*",                 # NDIS devices
    "*Bluetooth*",            # Bluetooth NICs
    "*RNDIS*"                 # USB tethering
)

foreach ($pattern in $blockList) {
    Get-PnpDevice -FriendlyName * | Where-Object { $_.InstanceId -like $pattern } | Enable-PnpDevice -Confirm:$false -ErrorAction SilentlyContinue
}

Write-Host ">>> Reverse SilentKill complete. The system is now back online."
