#Requires AutoHotkey v2.0
#SingleInstance Force

VDA := DllCall("LoadLibrary", "Str", A_ScriptDir "\VirtualDesktopAccessor.dll", "Ptr")
GoToProc    := DllCall("GetProcAddress", "Ptr", VDA, "AStr", "GoToDesktopNumber", "Ptr")
MoveWinProc := DllCall("GetProcAddress", "Ptr", VDA, "AStr", "MoveWindowToDesktopNumber", "Ptr")

SwitchDesktop(n, *) => (ToolTip("switch " n), SetTimer(() => ToolTip(), -800), DllCall(GoToProc, "Int", n, "Int"))
MoveActive(n, *) => DllCall(MoveWinProc, "Ptr", WinExist("A"), "Int", n, "Int")

; Alt + 1..9: Desktop wechseln
; Alt + Shift + 1..9: aktives Fenster auf Desktop verschieben
Loop 9 {
    Hotkey "!" A_Index, SwitchDesktop.Bind(A_Index - 1)
    Hotkey "!+" A_Index, MoveActive.Bind(A_Index - 1)
}

; Close Apps via [Alt]+W
!w:: {
    hwnd := WinExist("A")
    if !hwnd
        return
    cls := WinGetClass(hwnd)
    if cls = "Progman" || cls = "WorkerW" || cls = "Shell_TrayWnd" || cls = "Shell_SecondaryTrayWnd"
        return
    WinClose(hwnd)
}

; Toggle Maximize with [Alt]+F
!f:: {
    if WinGetMinMax("A") = 1
        WinRestore("A")
    else
        WinMaximize("A")
}

; Launch Windows Terminal
!Enter:: {
    Run "wt.exe"
}

; Launch Windows Terminal with WSL Ubuntu
^!Enter:: {
    Run 'wt.exe -p "Ubuntu-24.04"'
}

; Watchdog to fix hanging ALT keys
SetTimer(AltWatchdog, 200)
AltWatchdog() {
    for k in ["LAlt", "RAlt"] {
        if GetKeyState(k) && !GetKeyState(k, "P")
            Send "{Blind}{" k " up}"
    }
}
