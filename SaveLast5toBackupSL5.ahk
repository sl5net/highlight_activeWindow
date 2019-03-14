; Indentation_style: https://de.wikipedia.org/wiki/EinrÃ¼ckungsstil#SL5small-Stil

fileExtension=php,ahk,js,csv,htm,html,txt,mdb ; <= please konfig that !!! SL 14.11.2017 01:03


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; this is using this script without parameter !!! please use it wieth attribute ! 17.04.2017 16:36
;fullfile = E:\fre\private\HtmlDevelop\AutoHotKey\tools\TypingAid-master\Typing_Aid_everywhere_multi_clone.ahk
;fullfile := A_ScriptFullPath

; optonallli you could use a second parameter:
; example:
; E:\fre\private\HtmlDevelop\AutoHotKey>SaveLast5_to_BackupSL5.ahk E:\fre\blblabal.ahk c:\fre\private\Google_Drive\asldkf\backup
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

; Msgbox,%A_ScriptFullPath% = `n%A_ScriptFullPath%  `n fullfile=%fullfile% `n `n (from: %A_ScriptName%~%A_LineNumber%) 
; Msgbox,%A_ScriptDir% = `n%A_ScriptDir%  `n fullfile=%fullfile% `n `n (from: %A_ScriptName%~%A_LineNumber%) 

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ please config it in this file near line 30
isPutVersion2subFolders := true ; dont change filenames. put it in in different folders. 27.11.2017 13:39 17-11-27_13-39
; isPutVersion2subFolders := false
;>>>>>>>>>>>>>>>>>>>>>><>>>>>>>>>>>>>>>>>>>>>>>
#SingleInstance force
;~ The word IGNORE skips the dialog box and leaves the old instance running. In other words, attempts to launch an already-running script are ignored.
 

scriptDir := RegExReplace( A_ScriptDir, "(\\AutoHotKey).*" , "$1") ; maybe file is started from subfolder. 18.04.2017 12:18
SetWorkingDir, % scriptDir 

;Msgbox,17-11-13_16-30`n (%A_ScriptName%~%A_LineNumber%) 

#Include %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk
  
;Msgbox,17-11-13_16-32`n (%A_ScriptName%~%A_LineNumber%) 

#Include %A_ScriptDir%\inc_ahk\ScriptNameLetterIcon.inc.ahk
;Msgbox,%HardDriveLetter%`n (%A_ScriptName%~%A_LineNumber%)


feedbackMsgBoxCloseAllWindows()
feedbackMsgBox(A_ScriptName,FileAdrBackupDAY)


;<<<<<<<< previous <<<< 171030113549 <<<< 30.10.2017 11:35:49 <<<<
log =
(
---------------------------
SaveLast5_to_BackupSL5.ahk
---------------------------
Could not close the previous instance of this script.  Keep waiting?
---------------------------
Ja   Nein   
---------------------------
)


DetectHiddenWindows,Off
SetTitleMatchMode,1 ; 3 = exactliy
activeTitle=SaveLast5_to_BackupSL5.ahk ahk_class #32770 ahk_exe AutoHotkey.exe
IfWinExist,% activeTitle
{
	ToolTip,IfWinExist %activeTitle%
	Loop,100
	{
		IfWinNotExist,% activeTitle
			break
		ToolTip,WinClose %activeTitle%
		WinClose,% activeTitle
		Sleep,100
		WinKill,% activeTitle
		Sleep,100
		; SendMessage,{esc},,,,SaveLast5_to_BackupSL5.ahk ahk_class #32770 ahk_exe AutoHotkey.exe
		IfWinNotExist,% activeTitle
			break
	   WinActivate,% activeTitle
	   WinWaitActive,% activeTitle ,,1
	   Send,{Enter}
		ToolTip,% A_index
		Sleep,100
	}
	; feedbackMsgBoxCloseAllWindows()
	ExitApp
}
;>>>>>>>> previous >>>> 171030113557 >>>> 30.10.2017 11:35:57 >>>>


;~ Loop, %A_ProgramFiles%\*.txt, , 1  ; Recurse into subfolders.
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ next is source folder (variable dir). please config this 20.06.2013
;~ next folder (default was backupAHK) will be created below root Letter of your partition. you find everything there 20.06.2013
subFolderNameForBackUps:= "backup_with_SL5"
global subFolderNameForBackDRIVE
para2=%2%

if(para2){
	subFolderNameForBackDRIVE:=SubStr(para2,1,1)
	subFolderNameForBackUps:=SubStr(para2,4)
	; Msgbox,%subFolderNameForBackDRIVE% `n  %subFolderNameForBackUps%`n (%A_ScriptName%~%A_LineNumber%) 
	; subFolderNameForBackUps=fre\private\Google_Drive\fax.sl5net\backup
}

;Msgbox,%subFolderNameForBackDRIVE% `n  %subFolderNameForBackUps%`n (%A_ScriptName%~%A_LineNumber%)

show_tooltip=0       ; 1=show, anything else means hide

backUpFilePostfixModus:= "timestamp"
;~ if you use timestamp your folders explode may one day ;)
backUpFilePostfixModus:="seconds"
;~ seconds is overwriting or so.

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if(!fullfile)
fullfile=%1%
; if(!folderNameForBackUps)
;	folderNameForBackUps=%2%
if(0){
	MsgBox,%fullfile%
	ExitApp
}
if("debugging" AND false)
	fullfile:=A_ScriptFullPath

; Msgbox,%fullfile% `n thanks for going (from: %A_ScriptName%~%A_LineNumber%) 


if(not fullfile)
{
	msg=%A_ScriptName% expects (first) parameter fullfile `n like this `n %A_ScriptName% R:\blabla\someThink.ahk `n i recommand you to use it with tools like `n gulpJS or TheFolderSpy.exe (please read Read me.txt *f) `n or PsychoFolder.exe from Ferruh Mavituna. `n (%A_ScriptName%~%A_LineNumber%) 
	feedbackMsgBox(A_ScriptName,msg)
	ExitApp
	
	ToolTip5sec("!! Attension !! config is jet temporary hardcoded in the file !!! `n `n `n it saves last 5 file version to " . HardDriveLetter . ":\" . subFolderNameForBackUps . " of your Drive. `n Creates this folder if not exist. `n Is overwriting needet it overwrites the smaler one of the five files backup-versions. `n")

}
para1:=RegExReplace(fullfile,"^.*\\([^\\]*)\.\w+$","$1")
;~ patternFileNameWithoutDir=.*\\[^\\]*)\.\w+$
;~ To fetch all info:
SplitPath, fullfile, fileNameWithoutDir, dirNameWithoutFile, extName, fileName_no_ext, driveName
;~ fileNameWithoutDir:=RegExReplace(fullfile,"^(.*\\[^\\]*)\.\w+$","$1")
;~ dirNameWithoutFile:=RegExReplace(fullfile,"^(.*).*\\[^\\]*\.\w+$","$1")
;~ MsgBox,dirNameWithoutFile= %dirNameWithoutFile%
;~ ExitApp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; MsgBox,%HardDriveLetter%

Loop
{
	if( A_ComputerName = "22GHZ-8GBRAM" )
	{
			dir:=HardDriveLetter . ":\Zend\Apache2\htdocs\"
	}
	else
	{
		dir:=HardDriveLetter . ":\ZendServer\Apache2\htdocs\"
	}
	if(dirNameWithoutFile)
	{
		dir:=dirNameWithoutFile
		dir:=fullfile
	}
	
	if(extName) ; <== thats name given over fyyyyyyyyyyyyyyyyyyyyyyyy		fileExtension:=extName
	;~ SplitPath, fullfile, fileNameWithoutDir, dirNameWithoutFile, extName, fileName_no_ext, driveName
	
	versionBackup(dir,subFolderNameForBackUps,fileExtension,backUpFilePostfixModus,show_tooltip)
	
	if(dirNameWithoutFile){
		msg2 = fullfile=%fullfile%,  fileNameWithoutDir=%fileNameWithoutDir%,  `n dirNameWithoutFile=%dirNameWithoutFile%, extName=%extName%, `n  fileName_no_ext=%fileName_no_ext%, driveName=%driveName% `n 
		msg=dirNameWithoutFile ==> ExitApp %msg2% `n (%A_ScriptName%~%A_LineNumber%) 
       ; feedbackMsgBox(A_ScriptName,msg)

		ExitApp
	}

;~ dir:="R:\fre\private\HtmlDevelop\AutoHotKey\"
	;~ fileExtension=ahk
	;~ versionBackup(dir,subFolderNameForBackUps,fileExtension,backUpFilePostfixModus,show_tooltip)

	;~ dir:="R:\xampp\htdocs\"
	;~ fileExtension=php
	;~ versionBackup(dir,subFolderNameForBackUps,fileExtension,backUpFilePostfixModus,show_tooltip)
	Sleep,9000
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

versionBackup(m_dir, m_subFolderNameForBackUps, m_fileExtension, m_backUpFilePostfixModus, m_show_tooltip=0){
	global HardDriveLetter
	if(m_show_tooltip)
		ToolTip2sec(m_dir . " " . m_fileExtension)
	
	;~ MsgBox,%m_backUpFilePostfixModus%
	;MsgBox,%HardDriveLetter%
	
	
	if ( FileExist(m_dir) )
	{
		loopFilePattern:=m_dir
		;~ SplitPath, fullfile, fileNameWithoutDir, dirNameWithoutFile, extName, fileName_no_ext, driveName
		SplitPath, m_dir,, dirTemp
		SplitPath, m_dir,, dirTemp
		
	
		global subFolderNameForBackDRIVE
		if(subFolderNameForBackDRIVE)
			StringReplace,dirTemp,dirTemp, %HardDriveLetter%:\,%subFolderNameForBackDRIVE%:\
		;MsgBox,%dirTemp%

		backUpFolderRoot := fileCreateDirS(dirTemp, m_subFolderNameForBackUps)
	}
	else
	{
		loopFilePattern=%m_dir%\*.*
		global subFolderNameForBackDRIVE
		if(subFolderNameForBackDRIVE)
			StringReplace,m_dir,dirTemp, %HardDriveLetter%:\,%subFolderNameForBackDRIVE%:\
		backUpFolderRoot := fileCreateDirS(dirTemp, m_subFolderNameForBackUps)
	}
	Loop, %loopFilePattern%, , 1
	{
		;~ MsgBox,A_LoopFileDir = %A_LoopFileDir%
		if(InStr(A_LoopFileDir, m_subFolderNameForBackUps))
			continue
		
		isUsefulFileExt:=false
		
		this_ext:=""
		StringSplit, fileExtensionArray, m_fileExtension, `,
		Loop, %fileExtensionArray0%
		{
			this_ext := fileExtensionArray%a_index%
			;~ MsgBox, %a_index%: this_ext=%this_ext%
			
			StringLower, this_ext, this_ext
			StringLower, loopExt, A_LoopFileExt
			if( this_ext == loopExt )
			{
				isUsefulFileExt:=true
				break
			}
		}
		
		if(isUsefulFileExt == false){
			msg=this_ext=%this_ext% `n A_LoopFileName=%A_LoopFileName% `n  loopExt=%loopExt% `n isUsefulFileExt == false `n ==> continue (%A_ScriptName%~%A_LineNumber%) 
			; feedbackMsgBox(A_ScriptName,msg)
			MsgBox,% msg
			continue
		}
		
		
		FolderAdrBackUp:=backUpFolderRoot . SubStr(A_LoopFileDir,3)


		; MsgBox,backUpFolderRoot=%backUpFolderRoot% A_LoopFileDir=%A_LoopFileDir% `n (%A_ScriptName%~%A_LineNumber%) 
		;~ ExitApp
		
		
		if(m_show_tooltip)
			ToolTip2sec(A_LineFile . ": FolderAdrBackUp=" . FolderAdrBackUp)
		
		fileCreateDirS(FolderAdrBackUp,"")
		;~ FolderAdrBackUp:=A_LoopFileDir . "\" . m_subFolderNameForBackUps
		
		; MsgBox,%FolderAdrBackUp%  `n = FolderAdrBackUp `n (%A_ScriptName%~%A_LineNumber%) 

		if(isDir(A_LoopFileFullPath))
		{
			;~ MsgBox,%dir% \ %A_LoopFileName%
		}
		
		; strang signs in dir name ... better continue this
		FoundPos := RegExMatch(m_dir,"[%]+")
		if(FoundPos>0)
			{
			msg=strang signs in dir name ... better continue this `n (%A_ScriptName%~%A_LineNumber%)
			;MsgBox,% msg
			feedbackMsgBox(A_ScriptName,msg)
			continue
		}

		
		
		FoundPos := RegExMatch(m_dir,"[%]+")
		if(FoundPos>0){
			msg=better continue this `n (%A_ScriptName%~%A_LineNumber%) 
			;MsgBox,% msg
			feedbackMsgBox(A_ScriptName,msg)
			continue
		}
		FoundPos := RegExMatch(A_LoopFileName,"[%]+")
		if(FoundPos>0){
			msg=better continue this `n (%A_ScriptName%~%A_LineNumber%) 
			;MsgBox,% msg
			feedbackMsgBox(A_ScriptName,msg)
			continue
		}
		FileGetSize,FileSize,%A_LoopFileFullPath%
		
		if(FileSize <= 0 )
		{
			;~ ToolTip, :-(	%A_LoopFileName% dir=%dir% FileSize=%FileSize%
			; MsgBox, :-(	%A_LoopFileName% `n FileSize=%FileSize%
			if(m_show_tooltip)
				ToolTip2sec(":( FileSize <= 0 :" . A_LoopFileName . "           bzw " . A_LoopFileFullPath)
			msg=better continue this `n (%A_ScriptName%~%A_LineNumber%) 
			feedbackMsgBox(A_ScriptName,msg)
			continue
		}

		; MsgBox, %A_LoopFileName% `n FileSize=%FileSize%

		if(m_show_tooltip)
			ToolTip2sec(":) FileSize > 0 `n" . A_LoopFileName )


		sizeTxtFilePath=%FolderAdrBackUp%\size_txt
		
		;~ if(m_show_tooltip)
			;~ ToolTip5sec(A_LineFile . ": `nFolderAdrBackUp=" . FolderAdrBackUp . "`nsizeTxtFilePath=" . sizeTxtFilePath)

		fileCreateDirS(sizeTxtFilePath,"")
		
			;MsgBox,%sizeTxtFilePath%  `n = sizeTxtFilePath `n %FolderAdrBackUp%  `n = FolderAdrBackUp `n %FileAdrBackup% = FileAdrBackup `n (%A_ScriptName%~%A_LineNumber%) 
			
		; Path ??
		if(not FileExist(sizeTxtFilePath))
		{
			Clipboard=%sizeTxtFilePath%
			msg=hï¿½? exit `n not FileExist(%sizeTxtFilePath%) 
			feedbackMsgBox(A_ScriptName,msg)
			ExitApp
		}
		
		;~ MsgBox,%sizeTxtFilePath%
		;~ ExitApp
		
		sizeTxtFileAdr=%sizeTxtFilePath%\%A_LoopFileName%.size.txt
		;~ MsgBox,%sizeTxtFileAdr%
		IfExist,%sizeTxtFileAdr%
		{
			FileReadLine, FileSizeOld, %sizeTxtFileAdr%, 1
			;~ MsgBox,FileSizeOld=%FileSizeOld%
			if(FileSize == FileSizeOld)
				continue
			FileDelete,%sizeTxtFileAdr%
		}
		
		
		IfExist,%sizeTxtFileAdr%
		{
			; should never happen. is in development mode
			msg=IfExist %sizeTxtFileAdr% :( `n should never happen. is in development mode
			feedbackMsgBox(A_ScriptName,msg)
			ExitApp
		}
		FileAppend,%FileSize%, %sizeTxtFileAdr%
		
		if(m_backUpFilePostfixModus = "seconds")
		{
			; A_DD Current 2-digit day of the month (01-31). Synonymous with A_MDay.
			;~ 1 = overwrite existing files	
			if( NOT FileAdrBackup)
				FileAdrBackup=%FolderAdrBackUp%\%A_LoopFileName%.%A_Index%.%this_ext%
			fileSMALEST:=FileAdrBackup

			Loop,5
			{
				;~ FileAdrBackup=%FolderAdrBackUp%\%A_LoopFileName%.d%A_DD%s%A_Sec%.%this_ext%
				s:=SubStr(A_Sec,1,1) ; only one digit. its enough
				;~ FileAdrBackup=%FolderAdrBackUp%\%A_LoopFileName%.s%s%.%this_ext%
				FileAdrBackup=%FolderAdrBackUp%\%A_LoopFileName%.%A_Index%.%this_ext%
				IfNotExist,%FileAdrBackup%
				{
					fileSMALEST:=FileAdrBackup ; name not perfect. anyway. wasting time
					break
				}
				; The name of the variable in which to store the retrieved date-time in format YYYYMMDDHH24MISS. 
				;~ FileGetTime,fileTime,%FileAdrBackup%
				FileGetSize,fileSize,%FileAdrBackup%
				;~ if(fileTime < fileTimeOLDEST)
				if(fileSize < fileSizeOLDEST)
				{
					fileSizeSMALEST:=fileSize
					fileSMALEST:=FileAdrBackup
				}
			}
			;~ ToolTip,A_Index=%A_Index% : FileSize=%FileSize% FileSizeOld=%FileSizeOld% OK? sizeTxtFileAdr=%sizeTxtFileAdr%
			IfExist,%fileSMALEST%
				if(fileCopy_NAME_INJECTION(A_LoopFileFullPath, FolderAdrBackUp . "/" . A_LoopFileName, "A_DD", this_ext))
					if(fileCopy_NAME_INJECTION(A_LoopFileFullPath, FolderAdrBackUp . "/" . A_LoopFileName, "A_MM", this_ext))
						if(fileCopy_NAME_INJECTION(A_LoopFileFullPath, FolderAdrBackUp . "/" . A_LoopFileName, "A_YYYY", this_ext))
							ToolTip,
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		if(false)
		{
			msg=%fileSMALEST%
			feedbackMsgBox(A_ScriptName,msg)
			ExitApp 
		}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
			FileCopy,%A_LoopFileFullPath%,%fileSMALEST%,1
			if(m_show_tooltip)
				ToolTip2sec("FileCopy," . A_LoopFileFullPath . ", " . fileSMALEST . ",1")
		}
		else
		{
			FormatTime, timestamp, %A_now%,yy-MM-dd-HH-mm-ss
			FileAdrBackup=%FolderAdrBackUp%\%A_LoopFileName%.%timestamp%.%this_ext%
			;~ 0 = (default) do not overwrite existing files
			;~ MsgBox,FileCopy %A_LoopFileFullPath% %FileAdrBackup% 
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		if(0)
		{
			MsgBox,%FileAdrBackup%
			ExitApp
		}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
			FileCopy,%A_LoopFileFullPath%,%FileAdrBackup%,0
			if(m_show_tooltip)
				ToolTip2sec("FileCopy," . A_LoopFileFullPath . ", " . FileAdrBackup . ",0")
		}
		

		 ;~ MsgBox,%A_LoopFileName% dir=%dir% FileSize=%FileSize%
		;Sleep,1000
		
		if(m_show_tooltip)
			ToolTip, %A_LoopFileName% `n %A_LineNumber%: %A_LineFile%
	}
	;~ ToolTip,sync finished :)
	return
	
	sec:=1000
	s10:=1000*10
	m:=60*sec
	m5:=5*m
	m1:=1*m
	Sleep,%m1%
	;~ Sleep,%s10%
	;~ Sleep,%sec%
	;~ MsgBox,sdfdfg
	return
}


fileCopy_NAME_INJECTION(m_source, m_destination, m_dest_injectString_type, m_dest_ext)
{
					;~ if(fileCopy_NAME_INJECTION(A_LoopFileFullPath, FolderAdrBackUp . A_LoopFileName, "A_DD", this_ext))
						;~ if(fileCopy_NAME_INJECTION(A_LoopFileFullPath, FolderAdrBackUp . A_LoopFileName, "A_MM", this_ext))
							;~ if(fileCopy_NAME_INJECTION(A_LoopFileFullPath, FolderAdrBackUp . A_LoopFileName, "A_YYYY", this_ext))


	inJ:=""
	if(m_dest_injectString_type = "A_DD")
		inJ:="d" . A_DD
	if(m_dest_injectString_type = "A_MM")
		inJ:="m" . A_MM
	if(m_dest_injectString_type = "A_YYYY")
		inJ:="y" . A_YYYY

	if( strlen(inJ) < 1 ){
		msg= ( strlen(inJ) < 1 ) `n (%A_ScriptName%~%A_LineNumber%) 
		feedbackMsgBox(A_ScriptName,msg)
		return,false
	}
		;return,false
	
	global isPutVersion2subFolders
	if(!isPutVersion2subFolders){
		FileAdrBackupDAY=%m_destination%.%inJ%.%m_dest_ext%
        ;Msgbox,`n (%A_ScriptName%~%A_LineNumber%)
		;ExitApp    ;;;
	}else{
		FileAdrBackupDAY=%m_destination%.%inJ%.%m_dest_ext%
		feedbackMsgBox(A_ScriptName,FileAdrBackupDAY)
		Msgbox,`n (%A_ScriptName%~%A_LineNumber%)
		ExitApp
	}
	IfNotExist,%FileAdrBackupDAY%
	{
		FileCopy,%m_source%,%FileAdrBackupDAY%,0
		return,true
	}
	return,false
}

; isFile(Path)
; {
   ; Return !InStr(FileExist(Path), "D") 
; }

; isDir(Path)
; {
;    Return !!InStr(FileExist(Path), "D") 
; }

fileCreateDirS(dir,addSecondDir)
{
	growingPath := ""
	Loop, parse, dir, \
	{
		if(A_Index > 1)
			growingPath := growingPath . "\" . A_LoopField
		if(A_Index = 1)
		{
			growingPath := A_LoopField
			if(!FileExist(growingPath))
			{
				msg= %A_ThisFunc% `n A_ Index=%A_Index%: `n !FileExist(%growingPath%) `n dir=%dir% `n addSecondDir=%addSecondDir% `n (%A_ScriptName%~%A_LineNumber%) 
				feedbackMsgBox(A_ScriptName,msg)
				ExitApp
			}
			if(StrLen(addSecondDir)>0)
				growingPath := growingPath . "\" . addSecondDir
			backUpFolderRoot:=growingPath
		}
		if(!FileExist(growingPath))
		{
			;~ MsgBox, %A_Index% is %growingPath%.
			FileCreateDir,%growingPath%
		}
	}
	;~ MsgBox, %growingPath%.
	backUpFolder := growingPath
	return,backUpFolderRoot
}



#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
#Include *i %A_ScriptDir%\inc_ahk\ToolTipSec.inc.ahk