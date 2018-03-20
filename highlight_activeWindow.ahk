; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
#Persistent
#SingleInstance,force
#NoTrayIcon

SetTimer, DrawRect, 50
border_thickness = 6
border_color = FF0000

DrawRect:
WinGetPos, x, y, w, h, A

WinGet, OutputVar , MinMax, A
; make maximized windows movable
; -1: The window is minimized (WinRestore can unminimize it).  1: The window is maximized (WinRestore can unmaximize it).0: The window is neither minimized nor maximized.
if(OutputVar == 1){
    WinGet, activeWindowHwnd, ID, A
    activeMonitorHwnd := MDMF_FromHWND(activeWindowHwnd)
    ; monitors := MDMF_Enum()

    ;monitorHwndList := []
    ;For currentMonitorHwnd, info In monitors
    ;    monitorHwndList[A_Index] := currentMonitorHwnd

    ;nextMonitorHwnd := ""
    ;For currentMonitorHwnd, info In monitors
     ;   If (currentMonitorHwnd = activeMonitorHwnd)
      ;      nextMonitorHwnd := (A_Index=monitorHwndList.MaxIndex() ? monitorHwndList[1] : monitorHwndList[A_Index+1])

    activeMonitor := MDMF_GetInfo(activeMonitorHwnd)
    ;nextMonitor := MDMF_GetInfo(nextMonitorHwnd)

    ;WinGetPos, x, y, w, h, ahk_id %activeWindowHwnd%
    ;activeWindow := {Left:x, Top:y, Right:x+w, Bottom:y+h}

    ;relativePercPos := {}
    ;relativePercPos.Left := (activeWindow.Left-activeMonitor.Left)/(activeMonitor.Right-activeMonitor.Left)
    ;relativePercPos.Top := (activeWindow.Top-activeMonitor.Top)/(activeMonitor.Bottom-activeMonitor.Top)
    ;relativePercPos.Right := (activeWindow.Right-activeMonitor.Left)/(activeMonitor.Right-activeMonitor.Left)
    ;relativePercPos.Bottom := (activeWindow.Bottom-activeMonitor.Top)/(activeMonitor.Bottom-activeMonitor.Top)

    ;MsgBox % activeWindow.Top "`n" activeWindow.Left " - " activeWindow.Right "`n" activeWindow.Bottom
    ;MsgBox % relativePercPos.Top*100 "`n" relativePercPos.Left*100 " - " relativePercPos.Right*100 "`n" relativePercPos.Bottom*100

    ;activeWindowNewPos := {}
    ;activeWindowNewPos.Left := nextMonitor.Left+(nextMonitor.Right-nextMonitor.Left)*relativePercPos.Left
    ;activeWindowNewPos.Top := nextMonitor.Top+(nextMonitor.Bottom-nextMonitor.Top)*relativePercPos.Top

    ; WinMove, A,, activeWindowNewPos.Left, activeWindowNewPos.Top
   
   
;   WinGetPos,x,y,w,h
   x := activeMonitor.Left
   y := activeMonitor.Top
   w := activeMonitor.Right - activeMonitor.Left
   h := activeMonitor.Bottom - activeMonitor.Top
   WinRestore,A
   ToolTip,% "x=" x " (" A_LineNumber " " A_LineFile ")"
   Sleep,300
   WinMove,A,,% x + 5, % y + 3, % w - 6, % h - 120
   Sleep,700
   WinMove,A,,% x + 5, % y + 3, % w - 6, % h - 120
   Sleep,700
   WinMove,A,,% x + 5, % y + 3, % w - 6, % h - 120
   ToolTip,
}


Gui, +Lastfound +AlwaysOnTop +Toolwindow
iw:= w+4
ih:= h + 4
w:=w+ 8
h:=h + 8
x:= x - border_thickness
y:= y - border_thickness
Gui, Color, FF0000
Gui, -Caption
WinSet, Region, 0-0 %w%-0 %w%-%h% 0-%h% 0-0 %border_thickness%-%border_thickness% %iw%-%border_thickness% %iw%-%ih% %border_thickness%-%ih% %border_thickness%-%border_thickness%
try{
Gui, Show, w%w% h%h% x%x% y%y% NoActivate, Table awaiting Action
         } catch {
            Sleep,2000
         }
return




;Win+Enter to move the active window to the next screen
#Enter::
    WinGet, activeWindowHwnd, ID, A
    activeMonitorHwnd := MDMF_FromHWND(activeWindowHwnd)
    monitors := MDMF_Enum()

    monitorHwndList := []
    For currentMonitorHwnd, info In monitors
        monitorHwndList[A_Index] := currentMonitorHwnd

    nextMonitorHwnd := ""
    For currentMonitorHwnd, info In monitors
        If (currentMonitorHwnd = activeMonitorHwnd)
            nextMonitorHwnd := (A_Index=monitorHwndList.MaxIndex() ? monitorHwndList[1] : monitorHwndList[A_Index+1])

    activeMonitor := MDMF_GetInfo(activeMonitorHwnd)
    nextMonitor := MDMF_GetInfo(nextMonitorHwnd)

    WinGetPos, x, y, w, h, ahk_id %activeWindowHwnd%
    activeWindow := {Left:x, Top:y, Right:x+w, Bottom:y+h}

    relativePercPos := {}
    relativePercPos.Left := (activeWindow.Left-activeMonitor.Left)/(activeMonitor.Right-activeMonitor.Left)
    relativePercPos.Top := (activeWindow.Top-activeMonitor.Top)/(activeMonitor.Bottom-activeMonitor.Top)
    relativePercPos.Right := (activeWindow.Right-activeMonitor.Left)/(activeMonitor.Right-activeMonitor.Left)
    relativePercPos.Bottom := (activeWindow.Bottom-activeMonitor.Top)/(activeMonitor.Bottom-activeMonitor.Top)

    ;MsgBox % activeWindow.Top "`n" activeWindow.Left " - " activeWindow.Right "`n" activeWindow.Bottom
    ;MsgBox % relativePercPos.Top*100 "`n" relativePercPos.Left*100 " - " relativePercPos.Right*100 "`n" relativePercPos.Bottom*100

    activeWindowNewPos := {}
    activeWindowNewPos.Left := nextMonitor.Left+(nextMonitor.Right-nextMonitor.Left)*relativePercPos.Left
    activeWindowNewPos.Top := nextMonitor.Top+(nextMonitor.Bottom-nextMonitor.Top)*relativePercPos.Top

    WinMove, A,, activeWindowNewPos.Left, activeWindowNewPos.Top
Return

;Credits to "just me" for the following code:

; ======================================================================================================================
; Multiple Display Monitors Functions -> msdn.microsoft.com/en-us/library/dd145072(v=vs.85).aspx =======================
; ======================================================================================================================
; Enumerates display monitors and returns an object containing the properties of all monitors or the specified monitor.
; ======================================================================================================================
MDMF_Enum(HMON := "") {
   Static EnumProc := RegisterCallback("MDMF_EnumProc")
   Static Monitors := {}
   If (HMON = "") ; new enumeration
      Monitors := {}
   If (Monitors.MaxIndex() = "") ; enumerate
      If !DllCall("User32.dll\EnumDisplayMonitors", "Ptr", 0, "Ptr", 0, "Ptr", EnumProc, "Ptr", &Monitors, "UInt")
         Return False
   Return (HMON = "") ? Monitors : Monitors.HasKey(HMON) ? Monitors[HMON] : False
}
; ======================================================================================================================
;  Callback function that is called by the MDMF_Enum function.
; ======================================================================================================================
MDMF_EnumProc(HMON, HDC, PRECT, ObjectAddr) {
   Monitors := Object(ObjectAddr)
   Monitors[HMON] := MDMF_GetInfo(HMON)
   Return True
}
; ======================================================================================================================
;  Retrieves the display monitor that has the largest area of intersection with a specified window.
; ======================================================================================================================
MDMF_FromHWND(HWND) {
   Return DllCall("User32.dll\MonitorFromWindow", "Ptr", HWND, "UInt", 0, "UPtr")
}
; ======================================================================================================================
; Retrieves the display monitor that contains a specified point.
; If either X or Y is empty, the function will use the current cursor position for this value.
; ======================================================================================================================
MDMF_FromPoint(X := "", Y := "") {
   VarSetCapacity(PT, 8, 0)
   If (X = "") || (Y = "") {
      DllCall("User32.dll\GetCursorPos", "Ptr", &PT)
      If (X = "")
         X := NumGet(PT, 0, "Int")
      If (Y = "")
         Y := NumGet(PT, 4, "Int")
   }
   Return DllCall("User32.dll\MonitorFromPoint", "Int64", (X & 0xFFFFFFFF) | (Y << 32), "UInt", 0, "UPtr")
}
; ======================================================================================================================
; Retrieves the display monitor that has the largest area of intersection with a specified rectangle.
; Parameters are consistent with the common AHK definition of a rectangle, which is X, Y, W, H instead of
; Left, Top, Right, Bottom.
; ======================================================================================================================
MDMF_FromRect(X, Y, W, H) {
   VarSetCapacity(RC, 16, 0)
   NumPut(X, RC, 0, "Int"), NumPut(Y, RC, 4, Int), NumPut(X + W, RC, 8, "Int"), NumPut(Y + H, RC, 12, "Int")
   Return DllCall("User32.dll\MonitorFromRect", "Ptr", &RC, "UInt", 0, "UPtr")
}
; ======================================================================================================================
; Retrieves information about a display monitor.
; ======================================================================================================================
MDMF_GetInfo(HMON) {
   NumPut(VarSetCapacity(MIEX, 40 + (32 << !!A_IsUnicode)), MIEX, 0, "UInt")
   If DllCall("User32.dll\GetMonitorInfo", "Ptr", HMON, "Ptr", &MIEX) {
      MonName := StrGet(&MIEX + 40, 32)    ; CCHDEVICENAME = 32
      MonNum := RegExReplace(MonName, ".*(\d+)$", "$1")
      Return {Name:      (Name := StrGet(&MIEX + 40, 32))
            , Num:       RegExReplace(Name, ".*(\d+)$", "$1")
            , Left:      NumGet(MIEX, 4, "Int")    ; display rectangle
            , Top:       NumGet(MIEX, 8, "Int")    ; "
            , Right:     NumGet(MIEX, 12, "Int")   ; "
            , Bottom:    NumGet(MIEX, 16, "Int")   ; "
            , WALeft:    NumGet(MIEX, 20, "Int")   ; work area
            , WATop:     NumGet(MIEX, 24, "Int")   ; "
            , WARight:   NumGet(MIEX, 28, "Int")   ; "
            , WABottom:  NumGet(MIEX, 32, "Int")   ; "
            , Primary:   NumGet(MIEX, 36, "UInt")} ; contains a non-zero value for the primary monitor.
   }
   Return False
}