# Autostart virtual-desktop-switch.ahk with the UIAccess build, so the hotkeys also work over elevated windows.
# Runs after 10-winget-configure, which installs AutoHotkey on a new machine.
$exe = "$env:ProgramFiles\AutoHotkey\v2\AutoHotkey64_UIA.exe"
if (-not (Test-Path $exe)) {
    Write-Warning "AutoHotkey v2 is not installed yet. Run 'chezmoi apply' again once it is."
    exit 1
}
$script = Join-Path $HOME 'Documents\AutoHotkey\virtual-desktop-switch.ahk'
$link = (New-Object -ComObject WScript.Shell).CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\virtual-desktop-switch.ahk.lnk")
$link.TargetPath = $exe
$link.Arguments = "`"$script`""
$link.WorkingDirectory = Split-Path $script
$link.Save()
