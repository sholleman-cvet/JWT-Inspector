; Required libraries:
;   https://github.com/cocobelgica/AutoHotkey-JSON
;   https://github.com/jNizM/AHK_Scripts/blob/master/src/encoding_decoding/base64.ahk
; Remove the last two lines in Base64.ahk which begin with MsgBox 
; Put libaries in <Script Directory>/Lib/ 
#Include <JSON> 
#Include <Base64>

EpochTimestamp() {
    now := A_NowUTC ;UTC timestamp in YYYYMMDDHH24MISS format
    EnvSub, now, 19700101, Seconds ;subtract seconds since 1970/01/01
    return now
}

CustomMsgBox(TitleStr, EditStr, TextStr) {
    Gui,New
    Gui,Font,s12,%Font%
    Gui,Add,Edit,% "h"A_ScreenHeight*.60 ReadOnly,%EditStr%
    Gui,Add,Text,,%TextStr%
    Gui,Show,,%TitleStr%
    ControlSend,,{Left},%TitleStr% ;deselects the text
    return
    GuiClose:
    GuiEscape:
    Gui,Destroy
    return
}

!0:: 
jwtBodyObj := JSON.Load(b64Decode(StrSplit(Clipboard, ".")[2]))
jwtBodyBeautified := JSON.Dump(jwtBodyObj,,2)
secondsUntilExp := jwtBodyObj.exp - EpochTimestamp()
CustomMsgBox("JWT Inspector", jwtBodyBeautified, "Expires in: " secondsUntilExp " seconds.")
return
