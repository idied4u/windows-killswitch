# **Windows-Killswitch Network Lockdown Utility**

## **Overview**

**Windows-Killswitch** is a powerful tool designed to completely **lock down** and **disable network access** on your Windows system for **high security**. It blocks all network interfaces, disables Bluetooth, USB devices, and enforces a persistent firewall that blocks all inbound and outbound traffic. This tool is ideal for **paranoid security setups**, offline systems, or those needing complete network isolation.

The utility includes two parts:
1. **Windows-Killswitch**: The main lockdown script that disables network interfaces, ports, and devices.
2. **Reverse Windows-Killswitch**: A reverse script that restores all interfaces, services, and devices to their normal state.

---

## **Features**
- **Lockdown (Windows-Killswitch)**:
    - Disables **Wi-Fi** and **Ethernet** interfaces.
    - **Disables Bluetooth** (including discovery and pairing).
    - **Blocks all traffic** using Windows Firewall.
    - **Disables USB devices** and other network adapters over USB (RNDIS).
    - **Makes the firewall persistent** across reboots by adding firewall rules.

- **Reverse (Reverse Windows-Killswitch)**:
    - **Re-enables Wi-Fi** and **Ethernet** interfaces.
    - **Restores Bluetooth** and its services.
    - **Reverses firewall settings** by removing the blocking rules.
    - **Re-enables USB devices** and other network interfaces over USB.

---

## **Requirements**
- Windows system with **administrator privileges**.
- **SIP (System Integrity Protection)** is not applicable to Windows, but you may need administrative access to disable or enable devices.

---

## **How to Use Windows-Killswitch**

### 1. **Download the Scripts**
- Download the `Windows-Killswitch.ps1` script (the lockdown) and the `Reverse-Windows-Killswitch.ps1` script (the reverse) to your Windows system.

### 2. **Make Sure You Have Admin Rights**
- Both scripts require **administrator privileges** to run. Open **PowerShell as Administrator** to ensure proper execution.

### 3. **Run the Lockdown Script (Windows-Killswitch)**
To **lock down** the system, execute the following command with **PowerShell** running as Administrator:

### To reverse the lockdown, execute the reverse script with PowerShell running as Administrator.
