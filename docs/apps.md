# Apps

Every package that `winget/configuration.winget` installs, and what I use it for. This is my personal setup: comment out the blocks you don't need before applying.

## Apps

| App | winget ID | Why |
| --- | --- | --- |
| Discord | `Discord.Discord` | Chat and voice with friends and communities. |
| Microsoft Teams | `Microsoft.Teams` | Meetings and chat for work. |
| Spotify | `Spotify.Spotify` | Music. |
| Steam | `Valve.Steam` | Games. |

## Dev

| App | winget ID | Why |
| --- | --- | --- |
| Git | `Git.Git` | Version control; also brings Git Bash. |
| PowerShell 7 | `Microsoft.PowerShell` | Current PowerShell; chezmoi runs its scripts with it. |
| Windows Terminal | `Microsoft.WindowsTerminal` | Tabs and profiles for PowerShell, WSL and Git Bash. |
| WSL | `Microsoft.WSL` | Linux on Windows, needed for DDEV. |
| Visual Studio Code | `Microsoft.VisualStudioCode` | Main editor. |
| Visual Studio Community | `Microsoft.VisualStudio.Community` | .NET and C++ desktop development, .NET MAUI. Workloads come from [`winget/community.vsconfig`](../winget/community.vsconfig). |
| DDEV | `DDEVFoundation.DDEV` | Local PHP development environments in Docker. |
| DBeaver Community | `DBeaver.DBeaver.Community` | Database client. |
| Bruno | `Bruno.Bruno` | API client; collections live as files in Git. |
| Oh My Posh | `JanDeDobbeleer.OhMyPosh` | PowerShell prompt, Monokai Pro theme in `~/.config/oh-my-posh/`. Needs a [Nerd Font](https://www.nerdfonts.com/) in the terminal. |

## Tools

| App | winget ID | Why |
| --- | --- | --- |
| PowerToys | `Microsoft.PowerToys` | Peek, Advanced Paste, Color Picker, Hosts editor and more; settings in [`powertoys/`](../powertoys). |
| NanaZip | `M2Team.NanaZip` | 7-Zip with Windows 11 context menu integration. |
| LocalSend | `LocalSend.LocalSend` | Send files between devices on the local network. |
| WinDirStat | `WinDirStat.WinDirStat` | See what fills the disk. |
| AutoHotkey | `AutoHotkey.AutoHotkey` | Virtual desktop and window hotkeys, see [AutoHotkey](../README.md#autohotkey). |
| EurKEY | `SteffenBruentjen.EurKEY` | US-based keyboard layout with umlauts and European characters. |
| Obsidian | `Obsidian.Obsidian` | Notes as Markdown files. |
| Logseq | `Logseq.Logseq` | Outliner and journal. |
| ONLYOFFICE | `ONLYOFFICE.DesktopEditors` | Office documents without Microsoft 365. |
| Synology Drive Client | `Synology.DriveClient` | Sync with my Synology NAS. |
| OpenWhispr | `OpenWhispr.OpenWhispr` | Local speech-to-text dictation, see [OpenWhispr](../README.md#openwhispr). |
| Fastfetch | `Fastfetch-cli.Fastfetch` | System info in the terminal. |
| Windhawk | `RamenSoftware.Windhawk` | Mods for Windows itself, see [Windhawk mods](../README.md#windhawk-mods). |
| npiperelay | `albertony.npiperelay` | Windows SSH agent in WSL, see [SSH agent in WSL](../README.md#ssh-agent-in-wsl). |

## Browsers

| App | winget ID | Why |
| --- | --- | --- |
| Firefox Developer Edition (German) | `Mozilla.Firefox.DeveloperEdition.de` | Main browser and web development; gets the [Betterfox](../firefox/user.js) prefs. |
| Chromium | `Hibbiki.Chromium` | Testing in a Chromium engine without Google's Chrome. |

## Not on winget

- [NVIDIA Broadcast](https://www.nvidia.com/broadcast-app/): install via the NVIDIA App.
- [AI Usage](https://github.com/marco-kretz/AIUsage): install from its releases.
