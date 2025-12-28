**WSL Setup**: Quick steps to get a buildable Ubuntu environment for OpenVPN
- **Windows (Admin)**: Run the provided PowerShell script to enable WSL and install Ubuntu: `windows-msi/Install-WSL.ps1`.

- **From an elevated PowerShell**:

```powershell
# Run as Administrator
powershell -ExecutionPolicy Bypass -File windows-msi\Install-WSL.ps1
```

- **After reboot / once Ubuntu installed**:
- Launch the Ubuntu app (or run `wsl -d Ubuntu`).
- Recommended: clone the repository inside WSL, not on the Windows filesystem:

```bash
# inside WSL
cd ~
git clone https://github.com/<your-fork>/openvpn-build.git
cd openvpn-build
./scripts/wsl-build.sh
```

- If you prefer to build against the OneDrive copy on `/mnt/c/...`, be aware of performance and permission caveats; cloning inside WSL is more reliable.

- Notes:
  - The helper `./scripts/wsl-build.sh` installs common build packages and attempts to run `release/full-release-build.sh` if present.
  - If you need additional packages for specific distributions (Debian packaging, Windows MSI, etc.), install them as required.
