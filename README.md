# win11-dotfiles

My Windows 11 setup in one place, managed with [chezmoi](https://chezmoi.io): config files, registry tweaks and apps as a [WinGet Configuration](https://learn.microsoft.com/windows/package-manager/configuration/), plus the Windhawk mods and tools I use. Background: [Windows 11 entrümpeln und eigene Windhawk-Mod](https://marco-kretz.de/blog/windows-11-entruempeln-und-eigene-windhawk-mod/).

Tested on Windows 11 Pro 26H2 (build 26300).

> **This is my personal setup.** It installs apps and sets registry values that not everyone needs. Fork it and remove what you don't want before running `chezmoi apply`: comment out blocks in `winget/configuration.winget`, delete files you don't need.

## Setup on a new machine

```powershell
winget install jdx.mise Microsoft.PowerShell Git.Git
mise exec chezmoi -- chezmoi init --source $HOME\source\win11-dotfiles --apply marco-kretz/win11-dotfiles
mise install   # installs all tools from the mise config, chezmoi included
```

## Contents

- `dot_config/mise/config.toml`: global mise tools.
- `dot_config/autohotkey/`: AutoHotkey script, see [AutoHotkey](#autohotkey).
- `firefox/user.js`: Betterfox selection, copied into every Firefox profile on `chezmoi apply` (Firefox must be closed).
- `powertoys/*.json`: PowerToys settings, one file per module (`App.json` holds the general settings and which modules are on). Applied with `PowerToys.DSC.exe` on `chezmoi apply` whenever a file changes. After changing settings in PowerToys, refresh a snapshot:

  ```powershell
  & "$env:LOCALAPPDATA\PowerToys\PowerToys.DSC.exe" get --resource settings --module Peek | ConvertFrom-Json | Select-Object settings | ConvertTo-Json -Depth 20 | Set-Content powertoys\Peek.json
  ```

- `winget/community.vsconfig`: Visual Studio Community workloads, applied by the configuration. Refresh after changing workloads in the VS Installer: *More → Export configuration*.
- `winget/configuration.winget`: registry tweaks and apps ([docs/apps.md](docs/apps.md)), applied by `chezmoi apply` whenever the file changes (one UAC prompt for HKLM values). What each value does: [docs/registry-tweaks.md](docs/registry-tweaks.md).

## Daily use

- Add a file: `chezmoi add <path>`
- Preview / apply: `chezmoi diff`, `chezmoi apply`
- Check registry tweaks without changing anything: `winget configure test -f winget\configuration.winget`

## Registry tweaks

Some changes need a sign-out, restart or Explorer restart. Values under `...\Policies\...` make Settings show "managed by your organization".

To disable a tweak, comment out its block. That only stops applying it; to revert an already applied value, delete it (or set the Windows default) by hand, e.g.:

```powershell
Remove-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' SettingsPageVisibility
```

## Windhawk mods

Install via Windhawk (installed by the configuration). Settings live in Windhawk.

| Mod | Source |
| --- | --- |
| [Multi-DPI Cursor](https://windhawk.net/mods/multi-dpi-cursor) | [win11-multi-dpi-cursor](https://github.com/marco-kretz/win11-multi-dpi-cursor) |
| Desktop Dots (`desktop-dots`) | [win11-desktop-dots](https://github.com/marco-kretz/win11-desktop-dots) |
| Single Virtual Desktop (`single-virtual-desktop`) | [win11-single-virtual-desktop](https://github.com/marco-kretz/win11-single-virtual-desktop) |

## Apps

Everything available on winget is installed by the configuration; the full list with reasons is in [docs/apps.md](docs/apps.md). The rest by hand:

- [NVIDIA Broadcast](https://www.nvidia.com/broadcast-app/): not on winget, install via the NVIDIA App.
- [AI Usage](https://github.com/marco-kretz/AIUsage): Claude Code usage limits in the tray. Install from its releases (not on winget).

## AutoHotkey

`~/.config/autohotkey/virtual-desktop-switch.ahk` (AutoHotkey v2) starts with Windows via a shortcut in the Startup folder, using the UIAccess build so the hotkeys also work over elevated windows. The [VirtualDesktopAccessor](https://github.com/Ciantic/VirtualDesktopAccessor) DLL next to it is downloaded from the GitHub release by chezmoi (`.chezmoiexternal.toml`, pinned by SHA-256).

| Hotkey | Action |
| --- | --- |
| `Alt` + `1`…`9` | Switch to virtual desktop 1–9 |
| `Alt` + `Shift` + `1`…`9` | Move the active window to desktop 1–9 |
| `Alt` + `W` | Close the active window |
| `Alt` + `F` | Toggle maximize |
| `Alt` + `Enter` | Windows Terminal |
| `Ctrl` + `Alt` + `Enter` | Windows Terminal with the `Ubuntu-24.04` profile |

A watchdog releases `Alt` if Windows misses the key-up.

## SSH agent in WSL

The configuration installs [npiperelay](https://github.com/albertony/npiperelay) and keeps the Windows `ssh-agent` service running, so WSL can use the Windows agent through `socat` + `npiperelay.exe`. In WSL, install `socat` (e.g. `sudo apt install socat`) and add this to `~/.bashrc` or `~/.zshrc`. Replace `<windows-user>` with your Windows user name; `(Get-Command npiperelay).Source` in PowerShell prints the exact path.

```bash
NPIPERELAY="/mnt/c/Users/<windows-user>/AppData/Local/Microsoft/WinGet/Packages/albertony.npiperelay_Microsoft.Winget.Source_8wekyb3d8bbwe/npiperelay.exe"
export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
if ! socat -u OPEN:/dev/null UNIX-CLIENT:"$SSH_AUTH_SOCK" >/dev/null 2>&1; then
  rm -f "$SSH_AUTH_SOCK"
  (setsid socat UNIX-LISTEN:"$SSH_AUTH_SOCK",fork EXEC:"$NPIPERELAY -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
fi
```

The relay starts once per WSL session; later shells reuse the socket. Check with `ssh-add -l`, which should list the keys from the Windows agent.

## Manual steps

- Privacy & security: review app permissions (camera, microphone, location, contacts, email, call history, borderless screen capture).
- Privacy & security → General: advertising ID off.
- Diagnostic data: "Required" (the minimum on Home/Pro). `DiagTrack` stays enabled on purpose.
- Copilot and widgets were already off here; if not, see the `TurnOffWindowsCopilot` and `AllowNewsAndInterests` policies.
