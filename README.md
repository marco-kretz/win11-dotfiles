# win11-dotfiles

Dotfiles for Windows 11, managed with [chezmoi](https://chezmoi.io).

## Setup on a new machine

```powershell
winget install twpayne.chezmoi Microsoft.PowerShell jdx.mise
git clone https://github.com/marco-kretz/win11-dotfiles.git $HOME\source\win11-dotfiles
chezmoi init --source $HOME\source\win11-dotfiles --apply
```

## Contents

- `dot_config/mise/config.toml`: global mise tools.
- `firefox/user.js`: Betterfox selection, copied into every Firefox profile on `chezmoi apply` (Firefox must be closed).

## Daily use

- Add a file: `chezmoi add <path>`
- Preview / apply: `chezmoi diff`, `chezmoi apply`
