# Install-WSL.ps1 — run in an elevated PowerShell (Run as Administrator)
# Enables WSL & Virtual Machine Platform, installs Ubuntu, and optionally reboots.

function Require-Admin {
  $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
  if (-not $isAdmin) { Write-Error "This script must be run as Administrator."; exit 1 }
}
Require-Admin

Write-Host "Enabling WSL and Virtual Machine Platform features..."
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Set default WSL version 2 if available
try {
  wsl --set-default-version 2
} catch {
  Write-Host "Warning: Couldn't set default WSL v2 (older Windows). Proceeding..."
}

Write-Host "Installing Ubuntu distribution (may take a few minutes)..."
try {
  wsl --install -d Ubuntu
} catch {
  Write-Host "Note: 'wsl --install' may not be available on older Windows builds."
  Write-Host "If installation fails, run: wsl --list --online  and then wsl --install -d <Name>"
}

$resp = Read-Host "A reboot may be required for changes to take effect. Reboot now? (Y/N)"
if ($resp -match '^[Yy]') {
  Restart-Computer
} else {
  Write-Host "Please reboot manually before using WSL."
}
