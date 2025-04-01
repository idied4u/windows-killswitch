# windows kill switch
Write-Host "=== SilentKill: Windows Network Lockdown ==="

# Requires admin
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "You must run this script as Administrator!"
    exit
}

# Disable all network adapters
Write-Host "[+] Disabling all network adapters..."
Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Disable-NetAdapter -Confirm:$false

# Block all inbound and outbound traffic with Windows Firewall
Write-Host "[+] Blocking all inbound and outbound traffic using Windows Firewall..."
New-NetFirewallRule -DisplayName "SilentKill-In-All" -Direction Inbound -Action Block -Profile Any -Enabled True
New-NetFirewallRule -DisplayName "SilentKill-Out-All" -Direction Outbound -Action Block -Profile Any -Enabled True

# Optional: Disable Bluetooth service (if present)
Write-Host "[+] Attempting to disable Bluetooth service..."
Stop-Service bthserv -ErrorAction SilentlyContinue
Set-Service bthserv -StartupType Disabled

# Disable USB devices (Ethernet over USB, USB tethering, etc.)
Write-Host "[+] Disabling USB devices..."
$blockList = @(
    "USB\VID*",               # Generic USB devices
    "PCI\VEN*",               # PCI NICs
    "*TAP*",                  # Virtual interfaces (e.g. VPN)
    "*NDIS*",                 # NDIS devices
    "*Bluetooth*",            # Bluetooth NICs
    "*RNDIS*"                 # USB tethering
)

foreach ($pattern in $blockList) {
    Get-PnpDevice -FriendlyName * | Where-Object { $_.InstanceId -like $pattern } | Disable-PnpDevice -Confirm:$false -ErrorAction SilentlyContinue
}

Write-Host ">>> SilentKill Windows lockdown complete. This machine is now OFFLINE and firewalled."
