# win11-dotfiles

My Windows 11 setup in one place, managed with [chezmoi](https://chezmoi.io): config files, registry tweaks and apps as a [WinGet Configuration](https://learn.microsoft.com/windows/package-manager/configuration/), plus the Windhawk mods and tools I use. Background: [Windows 11 entrümpeln und eigene Windhawk-Mod](https://marco-kretz.de/blog/windows-11-entruempeln-und-eigene-windhawk-mod/).

Tested on Windows 11 Pro 26H2 (build 26300).

## Setup on a new machine

```powershell
winget install jdx.mise Microsoft.PowerShell Git.Git
mise exec chezmoi -- chezmoi init --source $HOME\source\win11-dotfiles --apply marco-kretz/win11-dotfiles
mise install   # installs all tools from the mise config, chezmoi included
```

## Contents

- `dot_config/mise/config.toml`: global mise tools.
- `firefox/user.js`: Betterfox selection, copied into every Firefox profile on `chezmoi apply` (Firefox must be closed).
- `winget/configuration.winget`: registry tweaks and apps, applied by `chezmoi apply` whenever the file changes (one UAC prompt for HKLM values). What each value does: [docs/registry-tweaks.md](docs/registry-tweaks.md).

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

- [AI Usage](https://github.com/marco-kretz/AIUsage): Claude Code usage limits in the tray. Install from its releases (not on winget).

## SSH agent in WSL

The configuration installs [npiperelay](https://github.com/albertony/npiperelay) and keeps the Windows `ssh-agent` service running, so WSL can use the Windows agent through `socat` + `npiperelay.exe`. The WSL side (`socat`, `SSH_AUTH_SOCK` setup) lives in the WSL distro.

## Manual steps

- Privacy & security: review app permissions (camera, microphone, location, contacts, email, call history, borderless screen capture).
- Privacy & security → General: advertising ID off.
- Diagnostic data: "Required" (the minimum on Home/Pro). `DiagTrack` stays enabled on purpose.
- Copilot and widgets were already off here; if not, see the `TurnOffWindowsCopilot` and `AllowNewsAndInterests` policies.
