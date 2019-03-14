; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil
#Persistent
#SingleInstance,force

;~ please use this ! as first line in every script before all includes! :)
isDevellopperMode:= true ; enthällt auch update script.

#Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk

/*
	ahk_class Shell_TrayWnd ahk_exe Explorer.EXE ahk_id 0x10188
	Cursor:  IBeam  ▪  Caret:  x102 y418  ▪  Client area:  x0 y0 w1920 h116
	
	Class NN:  MSTaskListWClass1  ▪  Win class:  MSTaskListWClass
	Pos:  x271 y0  ▪  x²1673 y²115  ▪  Size:  w1403 h116
	Pos relative client area:  x271 y0  ▪  x²1673 y²115
	Mouse relative control:  x1349 y91  ▪  0.9615, 0.7845
	HWND:  0x101ce  ▪  Focus control:  
	Style:  0x56000000  ▪  ExStyle:  0x00000000  ▪   hide styles 
*/
;WinGetPos,x,y,w,h,ahk_class Shell_TrayWnd ahk_exe Explorer.EXE
; msgbox, %w% %A_ScreenWidth%

#notrayicon

; taskbarArea := getTaskBarArea(doShowArea:=false) ; returns: taskbarArea := { x:, y:, rigth:, bottom:, w: , h: }


SetTimer,lblCheckTrayIconStatus,100 ; ; 30.08.2018 13:52 it sometimes happesn. and if it happens then its really ugly !!!! :( !!
SetTimer,timerLbl2000,2000 ; ; 30.08.2018 13:52 it sometimes happesn. and if it happens then its really ugly !!!! :( !!

;/¯¯¯¯ configuration ¯¯ 190215115120 ¯¯ 15.02.2019 11:51:20 ¯¯\
doMoveBottomInsideScreen := true
;\____ configuration __ 190215115123 __ 15.02.2019 11:51:23 __/


SetTimer, DrawRect, 700
border_thickness = 7
border_color = FF0000

DrawRect:
ifWinExist,Process Hacker;  [T540P-SL5NET\Administrator]+ ahk_class ProcessHacker ; mouseWindowTitle=0x40466  ; 
	pause

WinGetPos, x, y, w, h, A
; WinGetPos, x, y, w, h, Action List Appears Here


; too too too tooo tool

WinGet, OutputVar , MinMax, A
;WinGet, activeWindowHwnd, ID, Action List Appears Here
; make maximized windows movable
; -1: The window is minimized (WinRestore can unminimize it).  1: The window is maximized (WinRestore can unmaximize it).0: The window is neither minimized nor maximized.

isWindowMaximized := (OutputVar == 1)
;/¯¯¯¯ isWindowMaximized ¯¯ 190215110715 ¯¯ 15.02.2019 11:07:15 ¯¯\
WinGet, activeWindowHwnd, ID, A
if(isWindowMaximized){
	;WinGet, activeWindowHwnd, ID, Action List Appears Here
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
	
	taskbarArea := getTaskBarArea(doShowArea:=false) ; returns: taskbarArea := { x:, y:, rigth:, bottom:, w: , h: }
	taskbarMonitorNum := taskbarArea["taskbarMonitorNum"]
	if(taskbarMonitorNum == activeMonitor.Num)
		offset := 120
	else		
		offset := 20
	
;   WinGetPos,x,y,w,h
	x := activeMonitor.Left
	y := activeMonitor.Top
	w := activeMonitor.Right - activeMonitor.Left
	h := activeMonitor.Bottom - activeMonitor.Top
	WinRestore,A
	ToolTip,% "x=" x " (" A_LineNumber " " A_LineFile ")"
	
	; taskbarArea := { x:, y:, rigth:, bottom:, w: , h: }
	; layout := "|1 1| |2 2| _1 ¯1 _2 ¯2"
	pixFreeSpaceBeetween := 5
	if(taskbarMonitorNum == activeMonitor.Num){
		if(taskbarArea["layout"] == "¯1"){
		; taskbarArea := { x:, y:, rigth:, bottom:, w: , h: }
			xW := 1 ; + 5
			yW := taskbarArea["bottom"] - 3 + pixFreeSpaceBeetween
			hW := h - taskbarArea["bottom"]
			wW := w - 6
		}
		else if(taskbarArea["layout"] == "_1"){
		; taskbarArea := { x:, y:, rigth:, bottom:, w: , h: }
			xW := 1 ; + 5
			yW := - 3 - pixFreeSpaceBeetween
			hW := taskbarArea["y"]
			wW := w - 6
		}
		else if(taskbarArea["layout"] == "1|"){
		; taskbarArea := { x:, y:, rigth:, bottom:, w: , h: }
			xW := 1 ; + 5
			yW := - 3
			hW := h
			wW := taskbarArea["x"] - pixFreeSpaceBeetween
		}
		else if(taskbarArea["layout"] == "|1"){
		; taskbarArea := { x:, y:, rigth:, bottom:, w: , h: }
			xW := taskbarArea["w"] + pixFreeSpaceBeetween ; + 5
			yW := - 3
			hW := h
			wW := w - taskbarArea["w"] - 3
		}
		else if(taskbarArea["layout"] == "¯2"){
		; taskbarArea := { x:, y:, rigth:, bottom:, w: , h: }
			xW := taskbarArea["x"] ; + 5
			yW := taskbarArea["bottom"] - 3 + pixFreeSpaceBeetween
			hW := h - taskbarArea["bottom"]
			wW := w - 6
		}
		else if(taskbarArea["layout"] == "2|"){
		; taskbarArea := { x:, y:, rigth:, bottom:, w: , h: }
			xW := x ; + 5
			yW := - 3
			hW := h
			wW := w - taskbarArea["w"] - pixFreeSpaceBeetween
		}
		else if(taskbarArea["layout"] == "_2"){
		; taskbarArea := { x:, y:, rigth:, bottom:, w: , h: }
			xW := x ; + 5
			yW := - 3
			hW := taskbarArea["y"] - pixFreeSpaceBeetween
			wW := w - 6
		}
		else if(taskbarArea["layout"] == "|2"){
		; taskbarArea := { x:, y:, rigth:, bottom:, w: , h: }
			xW := taskbarArea["right"] + pixFreeSpaceBeetween ; + 5
			yW := - 3
			hW := h
			wW := w - taskbarArea["w"] - 3
		}
		else {
			ToolTip, % taskbarArea["right"] " = right"
	; ToolTip, % taskbarArea["layout"] " = layout"
			Clipboard := taskbarArea["layout"]
			msgbox, % taskbarArea["layout"] " = layout 19-03-14_13-34"
		}
		loop,3
		{
			Sleep,100
			WinMove,A,,% xW, % yW, % wW, % hW
		}
	  	; msgbox, % taskbarArea["layout"] " = layout" 
	}else{
		isTaskbarBottom := ( taskbarArea["y"] > A_ScreenHeight )
		
	  	; msgbox, % taskbarArea["layout"] " = layout 19-03-14_13-33"
		
		
		if(isTaskbarBottom){
		;Sleep,300
			WinMove,A,,% x + 5, % y + 3, % w - 6, % h - offset
			Sleep,700
			WinMove,A,,% x + 5, % y + 3, % w - 6, % h - offset
			Sleep,700
			WinMove,A,,% x + 5, % y + 3, % w - 6, % h - offset
		}else{
			Sleep,300
			WinMove,A,,% x + 5, % y + 3 + offset, % w - 6, % h - offset
			Sleep,700
			WinMove,A,,% x + 5, % y + 3 + offset, % w - 6, % h - offset
			Sleep,700
			WinMove,A,,% x + 5, % y + 3 + offset, % w - 6, % h - offset
		}
	}
	ToolTip,
}
;\____ isWindowMaximized __ 190215110723 __ 15.02.2019 11:07:23 __/
else{  
	
	if(doMoveBottomInsideScreen){
	;WinGet, activeWindowHwnd, ID, A
		WinGetPos , xTemp, yTemp, wTemp, hTemp, A ;, WinText, ExcludeTitle, ExcludeText
	; SysGet,Mon_BboxNew_,Monitor,0
		
		activeMonitorHwnd := MDMF_FromHWND(activeWindowHwnd)
		activeMonitor := MDMF_GetInfo(activeMonitorHwnd)
		if(yTemp + hTemp > activeMonitor.Bottom){
			hTemp := activeMonitor.Bottom - yTemp - 5
		; WinMove,A,,% x + 5, % y + 3, % w - 6, % h - 120
			WinGetActiveTitle,activeTitle
		; WinMove,% activeTitle,,% xTemp, % yTemp, % wTemp, % hTemp
		; msgbox,% yTemp "," hTemp ": " activeTitle
			WinMove,% activeTitle,, ,  ,  , % hTemp
		;WinMove,A,,% xTemp, % yTemp, % wTemp, % hTemp
		;WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
		}
	}
}


Gui, +Lastfound +AlwaysOnTop +Toolwindow
distance := 10
iw:= w + distance 
ih:= h + distance 
w:=w + distance  + border_thickness
h:=h + distance  + border_thickness
x:= x + border_thickness/4 - distance
y:= y + border_thickness/4 - distance

Gui, Color, FF0000
Gui, -Caption
WinSet, Region, 0-0 %w%-0 %w%-%h% 0-%h% 0-0 %border_thickness%-%border_thickness% %iw%-%border_thickness% %iw%-%ih% %border_thickness%-%ih% %border_thickness%-%border_thickness%
; toolTipGui(x, y, text, title := "", bgColor := "", fontSize := 0){
try{
	Gui, Show, w%w% h%h% x%x% y%y% NoActivate, Table awaiting Action
	
	; toolTipGui(x, y, text, title := "", bgColor := "", fontSize := 0)
	; GuiControl,  , % Gui1.HTXT, 11111111
	;Sleep,5000
} catch {
	Sleep,2000
}
; toolTipGui1 := toolTipGui(x,y,A_Tickcount ":" A_ScriptName) 

; sleep,2000
return



;Win+Enter to move the active window to the next screen
#Enter::
WinGet, activeWindowHwnd, ID, A
ToolTip2sec( "`n(" A_ThisFunc " " RegExReplace(A_LineFile,".*\\") ":"  A_LineNumber ")" )
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

; ~LButton:: ; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=62752
; sleep,200
; If( !GetKeyState("LButton") )
; return
; while(GetKeyState("LButton") )
; sleep,80
; taskbarArea := getTaskBarArea(doShowArea:=false)
; return

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

lblCheckTrayIconStatus:
showTempTrayIf_isNearTrayMenue(iconAdress)		
DetectHiddenWindows,Off
IfWinExist,%A_ScriptName%_icon,ExitApp %A_ScriptName% ; message from child DynaRun() script
{
	WinClose,%A_ScriptName%_icon
	ExitApp
}
return


timerLbl2000:
return


#Include *i %A_ScriptDir%\inc_ahk\taskBarBorder.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk 
